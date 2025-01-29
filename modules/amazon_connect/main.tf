resource "aws_connect_instance" "connect_instance" {
  identity_management_type = var.identity_management_type
  inbound_calls_enabled    = var.inbound_calls_enabled
  outbound_calls_enabled   = var.outbound_calls_enabled
  instance_alias           = var.instance_alias
  auto_resolve_best_voices_enabled = true

  tags = var.tags
}


# Amazon Connect Admin User
resource "aws_connect_user" "admin_user" {
  instance_id        = aws_connect_instance.connect_instance.id
  hierarchy_group_id = null  # Set if using hierarchy groups
 ## routing_profile_id = aws_connect_routing_profile.admin_routing_profile.id
 ## security_profile_ids = [aws_connect_security_profile.admin_profile.id]
  name                 = var.admin_user_name
  password             = var.admin_user_password
  identity_info {
    first_name = var.admin_first_name
    last_name  = var.admin_last_name
  }
  phone_config {
    phone_type       = "SOFT_PHONE"
    auto_accept      = true
    after_contact_work_time_limit = 0
  }
}