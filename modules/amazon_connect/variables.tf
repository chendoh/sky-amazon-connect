variable "identity_management_type" {
  description = "The type of identity management for the Amazon Connect instance."
  type        = string
  default     = "CONNECT_MANAGED"  # Other options: EXISTING_DIRECTORY, SAML
}

variable "inbound_calls_enabled" {
  description = "Enable inbound calls for Amazon Connect."
  type        = bool
  default     = true
}

variable "outbound_calls_enabled" {
  description = "Enable outbound calls for Amazon Connect."
  type        = bool
  default     = true
}

variable "instance_alias" {
  description = "Alias name for the Amazon Connect instance."
  type        = string
  default     = "immwalts-connect-instance"
}

variable "tags" {
  description = "Tags to assign to the Amazon Connect instance."
  type        = map(string)
  default = {
    Name        = "ImmaWaltsConnect"
    Environment = "Dev"
  }
}