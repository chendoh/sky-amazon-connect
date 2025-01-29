resource "aws_connect_instance" "connect_instance" {
  identity_management_type = var.identity_management_type
  inbound_calls_enabled    = var.inbound_calls_enabled
  outbound_calls_enabled   = var.outbound_calls_enabled
  instance_alias           = var.instance_alias
  auto_resolve_best_voices_enabled = true

  tags = var.tags
}