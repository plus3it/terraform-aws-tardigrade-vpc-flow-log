variable "log_destination_type" {
  description = "Controls whether to create the VPC Flow Log with a `cloud-watch-logs` or `s3` bucket destination"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for which the VPC Flow Log will be created"
  type        = string
  default     = null
}

variable "iam_role_arn" {
  description = "(Optional) ARN for the IAM role to attach to the flow log. If blank, a minimal role will be created"
  type        = string
  default     = null
}

variable "log_destination" {
  description = "(Optional) The ARN of the logging destination."
  type        = string
  default     = null
}

variable "log_format" {
  description = "(Optional) The fields to include in the flow log record, in the order in which they should appear."
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "(Optional) Name to assign to the CloudWatch Log Group. If blank, will use `/aws/vpc/flow-log/$$${var.vpc_id}`"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to the CloudWatch Log Group for the VPC Flow Log"
  type        = map(string)
  default     = {}
}
