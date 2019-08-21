variable "create_vpc_flow_log" {
  description = "Controls whether to create the VPC Flow Log"
  default     = true
}

variable "log_destination_type" {
  description = "Controls whether to create the VPC Flow Log with a CloudWatch Logs or S3 bucket destination"
  type        = "string"
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID for which the VPC Flow Log will be created"
  type        = "string"
  default     = ""
}

variable "iam_role_arn" {
  description = "(Optional) ARN for the IAM role to attach to the flow log. If blank, a minimal role will be created"
  type        = "string"
  default     = ""
}

variable "log_destination" {
  description = "(Optional) The ARN of the logging destination."
  type        = "string"
  default     = ""
}

variable "log_group_name" {
  description = "(Optional) Name to assign to the CloudWatch Log Group. If blank, will use `/aws/vpc/flow-log/$${var.vpc_id}`"
  type        = "string"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to the CloudWatch Log Group for the VPC Flow Log"
  type        = "map"
  default     = {}
}
