resource "aws_connect_instance" "connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  instance_alias           = var.instance_alias

# Required arguments
  outbound_calls_enabled = var.outbound_calls_enabled
  inbound_calls_enabled  = var.inbound_calls_enabled
}

resource "aws_connect_contact_flow" "contact_flow" {
  instance_id = aws_connect_instance.connect_instance.id
  name        = var.contact_flow_name
  content     = <<EOF
{
  "Version": "1.0",
  "Content": {
    "Version": "1.0",
    "StartAction": "SomeAction",
    "Actions": [
      {
        "ActionType": "PlayPrompt",
        "Parameters": {
          "Text": "Welcome to our contact center."
        }
      }
    ]
  }
}
EOF
  type        = "CONTACT_FLOW"
}




output "connect_instance_id" {
  value = aws_connect_instance.connect_instance.id
}

resource "aws_iam_role" "codebuild_service_role" {
  name = "codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = ["sts:AssumeRole"]
        Principal = {
          Service = ["codebuild.amazonaws.com"]
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
    "arn:aws:iam::aws:policy/AmazonLexFullAccess",
    "arn:aws:iam::aws:policy/AmazonConnect_FullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  ]
}

resource "aws_iam_role" "codepipeline_service_role" {
  name = "codepipeline-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "CodePipelinePermissions"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "iam:PassRole"
          ]
          Resource = "*"
          Effect   = "Allow"
          Condition = {
            StringEqualsIfExists = {
              "iam:PassedToService" = [
                "cloudformation.amazonaws.com",
                "elasticbeanstalk.amazonaws.com",
                "ec2.amazonaws.com",
                "ecs-tasks.amazonaws.com"
              ]
            }
          }
        },
        {
          Action = [
            "codecommit:CancelUploadArchive",
            "codecommit:GetBranch",
            "codecommit:GetCommit",
            "codecommit:GetRepository",
            "codecommit:GetUploadArchiveStatus",
            "codecommit:UploadArchive"
          ]
          Resource = "*"
          Effect   = "Allow"
        },
        # Add more permissions for the resources as per your document.
      ]
    })
  }
}

resource "aws_codebuild_project" "prereq_resources_project" {
  name          = "prereq-resources-project"
  service_role  = aws_iam_role.codebuild_service_role.arn
  buildspec     = file("/Users/Daddy/amazonconnect/sky-amazon-connect/modules/immawalts/buildspec-prereq.yaml")
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type = "GITHUB"
    location = "https://github.com/your-repository-url.git"
  }
}

## Connect resources build project
resource "aws_codebuild_project" "connect_resources_project" {
  name          = "connect-resources-project"
  service_role  = aws_iam_role.codebuild_service_role.arn
  buildspec     = file("/Users/Daddy/amazonconnect/sky-amazon-connect/modules/immawalts/buildspec-connect.yaml")
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type = "GITHUB"
    location = "https://github.com/your-repository-url.git"
  }
}

## CI-CD CodePipeline
resource "aws_codepipeline" "ci_cd_pipeline" {
  name = "ci-cd-pipeline"
  
  role_arn = aws_iam_role.codepipeline_service_role.arn

  artifact_store {
    location = "immawalts-bucket"
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceOutput"]
      configuration = {
        Owner      = "your-github-user"
        Repo       = "your-repository-name"
        Branch     = "main"
        OAuthToken = "your-github-oauth-token"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
      configuration = {
        ProjectName = aws_codebuild_project.prereq_resources_project.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name             = "DeployAction"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["BuildOutput"]
      output_artifacts = []
      configuration = {
        ProjectName = aws_codebuild_project.connect_resources_project.name
      }
    }
  }
}
