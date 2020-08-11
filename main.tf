provider "aws" {
}

locals {
  iam_role_name   = "flow-log-${format("%v", var.vpc_id)}"
  log_group_name  = var.log_group_name == null ? "/aws/vpc/flow-log/${format("%v", var.vpc_id)}" : var.log_group_name
  iam_role_arn    = var.iam_role_arn == null ? join("", aws_iam_role.this.*.arn) : var.iam_role_arn
  create_iam_role = var.log_destination_type == "cloud-watch-logs" && var.iam_role_arn == null
}

data "aws_partition" "current" {
}

data "aws_iam_policy_document" "role" {
  count = var.create_vpc_flow_log && local.create_iam_role ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:logs:*:*:log-group:${local.log_group_name}",
      "arn:${data.aws_partition.current.partition}:logs:*:*:log-group:${local.log_group_name}:*",
    ]
  }
}

data "aws_iam_policy_document" "trust" {
  count = var.create_vpc_flow_log && local.create_iam_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_flow_log" "this" {
  count = var.create_vpc_flow_log ? 1 : 0

  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination_type == "s3" ? var.log_destination : join("", aws_cloudwatch_log_group.this.*.arn)
  iam_role_arn         = local.iam_role_arn
  log_format           = var.log_format
  vpc_id               = var.vpc_id
  traffic_type         = "ALL"
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_vpc_flow_log && var.log_destination_type == "cloud-watch-logs" ? 1 : 0

  name = local.log_group_name
  tags = var.tags
}

resource "aws_iam_role" "this" {
  count = var.create_vpc_flow_log && local.create_iam_role ? 1 : 0

  name               = local.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.trust[0].json
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  count = var.create_vpc_flow_log && local.create_iam_role ? 1 : 0

  name   = local.iam_role_name
  role   = aws_iam_role.this[0].id
  policy = data.aws_iam_policy_document.role[0].json
}

