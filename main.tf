resource "aws_flow_log" "this" {
  # Source ID -- one of these must be set
  eni_id                        = var.flow_log.eni_id
  subnet_id                     = var.flow_log.subnet_id
  transit_gateway_attachment_id = var.flow_log.transit_gateway_attachment_id
  transit_gateway_id            = var.flow_log.transit_gateway_id
  vpc_id                        = var.flow_log.vpc_id

  # Options
  deliver_cross_account_role = var.flow_log.deliver_cross_account_role
  iam_role_arn               = local.cloudwatch_iam_role_arn
  log_destination_type       = var.flow_log.log_destination_type
  log_destination            = local.create_log_group ? one(aws_cloudwatch_log_group.this[*].arn) : var.flow_log.log_destination
  log_format                 = var.flow_log.log_format
  max_aggregation_interval   = var.flow_log.transit_gateway_attachment_id != null || var.flow_log.transit_gateway_id != null ? 60 : var.flow_log.max_aggregation_interval
  traffic_type               = var.flow_log.traffic_type

  tags = merge(
    {
      Name = var.flow_log.name
    },
    var.flow_log.tags,
  )

  dynamic "destination_options" {
    for_each = var.flow_log.destination_options != null ? [var.flow_log.destination_options] : []
    content {
      file_format                = destination_options.value.file_format
      hive_compatible_partitions = destination_options.value.hive_compatible_partitions
      per_hour_partition         = destination_options.value.per_hour_partition
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  count = local.create_log_group ? 1 : 0

  name = local.log_group_name

  kms_key_id        = var.flow_log.cloudwatch_log_group.kms_key_id
  log_group_class   = var.flow_log.cloudwatch_log_group.log_group_class
  retention_in_days = var.flow_log.cloudwatch_log_group.retention_in_days
  skip_destroy      = var.flow_log.cloudwatch_log_group.skip_destroy

  tags = merge(
    {
      Name = local.log_group_name
    },
    var.flow_log.cloudwatch_log_group.tags,
  )
}

resource "aws_iam_role" "cloudwatch" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  name               = local.cloudwatch_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_trust[0].json

  tags = merge(
    {
      Name = local.cloudwatch_iam_role_name
    },
    var.flow_log.tags,
  )
}

resource "aws_iam_role_policy" "cloudwatch" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  name   = local.cloudwatch_iam_role_name
  role   = aws_iam_role.cloudwatch[0].id
  policy = data.aws_iam_policy_document.cloudwatch_policy[0].json
}

resource "aws_iam_role_policies_exclusive" "cloudwatch" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  role_name    = aws_iam_role.cloudwatch[0].name
  policy_names = [aws_iam_role_policy.cloudwatch[0].name]
}

locals {
  source_id = coalesce(
    var.flow_log.eni_id,
    var.flow_log.subnet_id,
    var.flow_log.transit_gateway_attachment_id,
    var.flow_log.transit_gateway_id,
    var.flow_log.vpc_id,
  )

  create_cloudwatch_iam_role = var.flow_log.iam_role_arn == null && var.flow_log.log_destination_type == "cloud-watch-logs"
  cloudwatch_iam_role_arn    = local.create_cloudwatch_iam_role ? coalesce(one(aws_iam_role.cloudwatch[*].arn), aws_iam_role_policy.cloudwatch[0].name) : var.flow_log.iam_role_arn
  cloudwatch_iam_role_name   = "flow-log-cloudwatch-${format("%v", local.source_id)}"

  create_log_group = var.flow_log.cloudwatch_log_group.enable && var.flow_log.log_destination_type == "cloud-watch-logs"
  log_group_name   = var.flow_log.cloudwatch_log_group.name == null ? "/aws/vendedlogs/flow-log/${format("%v", local.source_id)}" : var.flow_log.cloudwatch_log_group.name

  account_id = data.aws_caller_identity.this.account_id
  partition  = data.aws_partition.this.partition
  region     = data.aws_region.this.name
}

data "aws_caller_identity" "this" {}
data "aws_partition" "this" {}
data "aws_region" "this" {}

data "aws_iam_policy_document" "cloudwatch_policy" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:${local.partition}:logs:*:*:log-group:${local.log_group_name}",
      "arn:${local.partition}:logs:*:*:log-group:${local.log_group_name}:*",
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch_trust" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:ec2:${local.region}:${local.account_id}:vpc-flow-log/*"]
    }
  }
}
