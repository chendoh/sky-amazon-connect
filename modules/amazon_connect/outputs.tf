output "amazon_connect_instance_id" {
  description = "Amazon Connect instance ID."
  value       = aws_connect_instance.connect_instance.id
}

output "amazon_connect_instance_arn" {
  description = "Amazon Connect instance ARN."
  value       = aws_connect_instance.connect_instance.arn
}
