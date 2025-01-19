variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the secret"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the secret"
  type        = string
}
