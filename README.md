# terraform-aws-tardigrade-vpc-flow-log

Terraform module to create a VPC Flow Log

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.68.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_flow_log"></a> [flow\_log](#input\_flow\_log) | Object of attributes for managing a Flow Log | <pre>object({<br>    name                 = string<br>    log_destination_type = string<br><br>    eni_id                        = optional(string)<br>    subnet_id                     = optional(string)<br>    transit_gateway_id            = optional(string)<br>    transit_gateway_attachment_id = optional(string)<br>    vpc_id                        = optional(string)<br><br>    deliver_cross_account_role = optional(string)<br>    iam_role_arn               = optional(string)<br>    log_destination            = optional(string)<br>    log_format                 = optional(string)<br>    max_aggregation_interval   = optional(number)<br>    tags                       = optional(map(string), {})<br>    traffic_type               = optional(string, "ALL")<br><br>    destination_options = optional(object({<br>      file_format                = optional(string)<br>      hive_compatible_partitions = optional(bool)<br>      per_hour_partition         = optional(bool)<br>    }))<br><br>    cloudwatch_log_group = optional(object({<br>      enable            = optional(bool, true)<br>      name              = optional(string)<br>      kms_key_id        = optional(string)<br>      log_group_class   = optional(string, "INFREQUENT_ACCESS")<br>      retention_in_days = optional(number, 30)<br>      skip_destroy      = optional(bool, false)<br>      tags              = optional(map(string), {})<br>    }), {})<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#output\_cloudwatch\_log\_group) | Object of attributes for the CloudWatch Log Group |
| <a name="output_flow_log"></a> [flow\_log](#output\_flow\_log) | Object of attributes for the Flow Log |
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role) | Object of attributes for the IAM Role used by the Flow Log |

<!-- END TFDOCS -->

## Testing

Manual testing:

```
# Replace "xxx" with an actual AWS profile, then execute the integration tests.
export AWS_PROFILE=xxx 
make terraform/pytest PYTEST_ARGS="-v --nomock"
```

For automated testing, PYTEST_ARGS is optional and no profile is needed:

```
make mockstack/up
make terraform/pytest PYTEST_ARGS="-v"
make mockstack/clean
```
