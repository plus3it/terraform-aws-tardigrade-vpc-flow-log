# terraform-aws-tardigrade-vpc-flow-log

Terraform module to create a VPC Flow Log

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_vpc\_flow\_log | Controls whether to create the VPC Flow Log | string | `"true"` | no |
| iam\_role\_arn | (Optional) ARN for the IAM role to attach to the flow log. If blank, a minimal role will be created | string | `""` | no |
| log\_destination | (Optional) The ARN of the logging destination. | string | `""` | no |
| log\_destination\_type | Controls whether to create the VPC Flow Log with a CloudWatch Logs or S3 bucket destination | string | `""` | no |
| log\_group\_name | (Optional) Name to assign to the CloudWatch Log Group. If blank, will use `/aws/vpc/flow-log/$${var.vpc_id}` | string | `""` | no |
| tags | A map of tags to add to the CloudWatch Log Group for the VPC Flow Log | map | `<map>` | no |
| vpc\_id | VPC ID for which the VPC Flow Log will be created | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| flow\_log\_id | The ID of the VPC Flow Log |
| iam\_role\_arn | ARN of the IAM Role for the VPC Flow Log |
| iam\_role\_name | Name of the IAM Role for the VPC Flow Log |
| iam\_role\_unique\_id | Unique ID of the IAM Role for the VPC Flow Log |
| log\_group\_arn | ARN of the Log Group for the VPC Flow Log |

