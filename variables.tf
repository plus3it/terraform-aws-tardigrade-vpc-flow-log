variable "flow_log" {
  description = "Object of attributes for managing a Flow Log"
  type = object({
    name                 = string
    log_destination_type = string

    eni_id                        = optional(string)
    subnet_id                     = optional(string)
    transit_gateway_id            = optional(string)
    transit_gateway_attachment_id = optional(string)
    vpc_id                        = optional(string)

    deliver_cross_account_role = optional(string)
    iam_role_arn               = optional(string)
    log_destination            = optional(string)
    log_format                 = optional(string)
    max_aggregation_interval   = optional(number)
    tags                       = optional(map(string), {})
    traffic_type               = optional(string, "ALL")

    destination_options = optional(object({
      file_format                = optional(string)
      hive_compatible_partitions = optional(bool)
      per_hour_partition         = optional(bool)
    }))

    cloudwatch_log_group = optional(object({
      enable            = optional(bool, true)
      name              = optional(string)
      kms_key_id        = optional(string)
      log_group_class   = optional(string, "INFREQUENT_ACCESS")
      retention_in_days = optional(number, 30)
      skip_destroy      = optional(bool, false)
      tags              = optional(map(string), {})
    }), {})
  })
}
