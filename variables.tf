variable "instance_alias" {
  description = "Alias for the Amazon Connect instance"
  type        = string
}

variable "inbound_flow_name" {
  description = "Name of the inbound contact flow"
  type        = string
}

variable "contact_flow_name" {
  description = "Name of the contact flow"
  type        = string
}

variable "admin_user" {
  description = "Admin username for Amazon Connect"
  type        = string
}

variable "admin_phone_number" {
  description = "Admin phone number"
  type        = string
}

variable "outbound_calls_enabled" {
  description = "Enable outbound calls for the Amazon Connect instance"
  type        = bool
  default     = true
}

variable "inbound_calls_enabled" {
  description = "Enable inbound calls for the Amazon Connect instance"
  type        = bool
  default     = true
}
