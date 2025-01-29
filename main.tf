module "amazon_connect" {
  source                  = "./modules/amazon_connect"
  identity_management_type = var.identity_management_type
  inbound_calls_enabled    = var.inbound_calls_enabled
  outbound_calls_enabled   = var.outbound_calls_enabled
  instance_alias           = var.instance_alias
  tags                     = var.tags


  admin_user_name      = var.admin_user_name
  admin_user_password  = var.admin_user_password
  admin_first_name     = var.admin_first_name
  admin_last_name      = var.admin_last_name
}
