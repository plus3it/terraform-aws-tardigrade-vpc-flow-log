# VPC Flow Log
output "flow_log_id" {
  description = "The ID of the VPC Flow Log"
  value       = "${join("", aws_flow_log.this.*.id)}"
}

output "log_group_arn" {
  description = "ARN of the Log Group for the VPC Flow Log"
  value       = "${join("", aws_cloudwatch_log_group.this.*.arn)}"
}

output "iam_role_arn" {
  description = "ARN of the IAM Role for the VPC Flow Log"
  value       = "${join("", aws_iam_role.this.*.arn)}"
}

output "iam_role_unique_id" {
  description = "Unique ID of the IAM Role for the VPC Flow Log"
  value       = "${join("", aws_iam_role.this.*.unique_id)}"
}

output "iam_role_name" {
  description = "Name of the IAM Role for the VPC Flow Log"
  value       = "${join("", aws_iam_role.this.*.name)}"
}
