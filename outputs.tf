# VPC Flow Log
output "flow_log" {
  description = "Object of attributes for the Flow Log"
  value       = aws_flow_log.this
}

output "cloudwatch_log_group" {
  description = "Object of attributes for the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this
}

output "iam_role" {
  description = "Object of attributes for the IAM Role used by the Flow Log"
  value       = aws_iam_role.cloudwatch
}
