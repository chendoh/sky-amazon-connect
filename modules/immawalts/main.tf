# Create the Amazon Connect instance
resource "aws_connect_instance" "connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  instance_alias           = var.instance_alias

  outbound_calls_enabled   = var.outbound_calls_enabled
  inbound_calls_enabled    = var.inbound_calls_enabled
}

output "connect_instance_id" {
  value = aws_connect_instance.connect_instance.id
}

# Create the Amazon Connect Contact Flow
resource "aws_connect_contact_flow" "immawalts_main" {
  instance_id = aws_connect_instance.connect_instance.id  # Reference the Connect instance ID directly
  name        = "immawalts_main"
  content     = <<EOF
{
  "Version": "1.0",
  "Content": {
    "Version": "1.0",
    "StartAction": "PlayPrompt",
    "Actions": [
      {
        "ActionType": "PlayPrompt",
        "Parameters": {
          "Text": "Welcome to Amazon Connect!"
        }
      }
    ]
  }
}
EOF
  type = "CONTACT_FLOW"
}

