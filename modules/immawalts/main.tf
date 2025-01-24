# Create the Amazon Connect instance
resource "aws_connect_instance" "connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  instance_alias           = var.instance_alias

  outbound_calls_enabled   = var.outbound_calls_enabled
  inbound_calls_enabled    = var.inbound_calls_enabled
}

output "connect_instance_id" {
  value = aws_connect_instance.connect_instance.id
}

resource "aws_secretsmanager_secret" "user_credentials" {
  name        = "immawalts_user_credentials"
  description = "Store username and password for Amazon Connect user"

  tags = {
    "Environment" = "Production"
  }
}

resource "aws_secretsmanager_secret_version" "user_credentials_version" {
  secret_id     = aws_secretsmanager_secret.user_credentials.id
  secret_string = jsonencode({
    username = "immawalts"
    password = " "
  })
}


resource "aws_iam_policy" "github_actions_policy" {
  name        = "GitHubActionsPolicy"
  description = "Policy to allow GitHub Actions to manage Amazon Connect resources"
  
  # Adjust the permissions according to your needs
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "connect:CreateContactFlow",
          "connect:UpdateContactFlow",
          "connect:DescribeContactFlow",
          "connect:ListContactFlows",
          "connect:DeleteContactFlow",
          "iam:ListRoles",
          "cloudwatch:PutMetricData",
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sts.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_attach" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
