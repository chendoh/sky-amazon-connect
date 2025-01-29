module "amazon_connect" {
  source                  = "./modules/amazon_connect"
  identity_management_type = var.identity_management_type
  inbound_calls_enabled    = var.inbound_calls_enabled
  outbound_calls_enabled   = var.outbound_calls_enabled
  instance_alias           = var.instance_alias
  tags                     = var.tags
}
