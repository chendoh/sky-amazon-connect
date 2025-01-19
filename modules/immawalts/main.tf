resource "aws_connect_instance" "connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  instance_alias           = var.instance_alias

# Required arguments
  outbound_calls_enabled = var.outbound_calls_enabled
  inbound_calls_enabled  = var.inbound_calls_enabled
}

resource "aws_connect_contact_flow" "contact_flow" {
  instance_id = aws_connect_instance.connect_instance.id
  name        = var.contact_flow_name
  content     = file("./modules/main_flow.json") # Ensure this JSON file exists in the module directory
  type        = "CONTACT_FLOW"
}



output "connect_instance_id" {
  value = aws_connect_instance.connect_instance.id
}
