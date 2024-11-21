module "flow_log_cloudwatch" {
  source = "../../"

  flow_log = {
    name                 = "${local.test_name}-cloudwatch-${local.id}"
    log_destination_type = "cloud-watch-logs"
    vpc_id               = module.vpc.vpc_id
  }
}

module "flow_log_s3" {
  source = "../../"

  flow_log = {
    name                 = "${local.test_name}-s3-${local.id}"
    log_destination_type = "s3"
    log_destination      = aws_s3_bucket.this.arn
    vpc_id               = module.vpc.vpc_id
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${local.test_name}-vpc-${local.id}"
  cidr = "10.0.0.0/16"
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
