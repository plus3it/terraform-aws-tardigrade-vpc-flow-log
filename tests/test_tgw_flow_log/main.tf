module "flow_log_cloudwatch" {
  source = "../../"

  flow_log = {
    name                 = "${local.test_name}-cloudwatch-${local.id}"
    log_destination_type = "cloud-watch-logs"
    transit_gateway_id   = aws_ec2_transit_gateway.this.id
  }
}

module "flow_log_s3" {
  source = "../../"

  flow_log = {
    name                 = "${local.test_name}-s3-${local.id}"
    log_destination_type = "s3"
    log_destination      = aws_s3_bucket.this.arn
    transit_gateway_id   = aws_ec2_transit_gateway.this.id
  }
}

resource "aws_ec2_transit_gateway" "this" {
  description = "${local.test_name}-tgw-${local.id}"

  tags = {
    Name = "${local.test_name}-tgw-${local.id}"
  }
}

resource "aws_s3_bucket" "this" {
  bucket        = "${local.test_name}-s3-bucket-${local.id}"
  force_destroy = true
}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

locals {
  test_name = "tardigrade-test-flow-log"
  id        = random_string.this.result
}
