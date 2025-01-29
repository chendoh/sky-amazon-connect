variable "aws_region" {
  description = "AWS region to deploy the Amazon Connect instance."
  type        = string
  default     = "us-east-1"
}

variable "identity_management_type" {
  description = "The type of identity management for Amazon Connect."
  type        = string
  default     = "CONNECT_MANAGED"
}

variable "inbound_calls_enabled" {
  description = "Enable inbound calls."
  type        = bool
  default     = true
}

variable "outbound_calls_enabled" {
  description = "Enable outbound calls."
  type        = bool
  default     = true
}

variable "instance_alias" {
  description = "Alias name for the Amazon Connect instance."
  type        = string
  default     = "immawalts-connect-instance"
}

variable "tags" {
  description = "Tags for the Amazon Connect instance."
  type        = map(string)
  default = {
    Name        = "ImmaWaltsConnect"
    Environment = "Dev"
  }
}
