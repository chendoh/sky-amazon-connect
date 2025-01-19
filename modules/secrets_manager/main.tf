resource "aws_secretsmanager_secret" "admin_secret" {
  name        = var.secret_name
  description = "Admin credentials for Amazon Connect"
}

resource "aws_secretsmanager_secret_version" "admin_secret_version" {
  secret_id     = aws_secretsmanager_secret.admin_secret.id
  secret_string = jsonencode({
    username = var.admin_username
    password = var.admin_password
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.admin_secret.arn
}
