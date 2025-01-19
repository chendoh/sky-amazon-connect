module "immawalts" {
  source            = "./modules/immawalts"
  instance_alias     = var.instance_alias
  inbound_flow_name  = var.inbound_flow_name
  contact_flow_name  = var.contact_flow_name
  admin_user         = var.admin_user
  admin_phone_number = var.admin_phone_number
}

module "secrets_manager" {
  source         = "./modules/secrets_manager"
  secret_name    = "admin_credentials"
  admin_username = var.admin_user
  admin_password = random_password.admin_password.result
}

resource "random_password" "admin_password" {
  length           = 6
  special          = false
  override_special = "_%@!"
}
