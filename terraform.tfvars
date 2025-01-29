aws_region               = "us-east-1"
identity_management_type = "CONNECT_MANAGED"
inbound_calls_enabled    = true
outbound_calls_enabled   = true
instance_alias           = "customer-support-connect"
admin_user_name          = "Wndoh"
admin_first_name         = "Walters"
admin_last_name          = "Ndoh"
admin_user_password      = "Password123!"

tags = {
  Name        = "Customer Support Connect"
  Environment = "Production"
}
