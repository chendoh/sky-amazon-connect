aws_region               = "us-east-1"
identity_management_type = "CONNECT_MANAGED"
inbound_calls_enabled    = true
outbound_calls_enabled   = true
instance_alias           = "customer-support-connect"

tags = {
  Name        = "Customer Support Connect"
  Environment = "Production"
}
