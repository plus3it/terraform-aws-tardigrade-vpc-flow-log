resource "random_id" "name" {
  byte_length = 6
  prefix      = "terraform-aws-vpc-flow-log-"
}

resource "aws_s3_bucket" "this" {
  bucket = random_id.name.hex
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.14.0"

  providers = {
    aws = aws
  }

  name = "tardigrade-vpc-flow-log-testing"
  cidr = "10.0.0.0/16"
}

module "baseline_s3_log_format" {
  source = "../../"
  providers = {
    aws = aws
  }

  vpc_id               = module.vpc.vpc_id
  log_destination_type = "s3"
  log_destination      = aws_s3_bucket.this.arn
  log_format           = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${vpc-id} $${subnet-id} $${instance-id} $${tcp-flags} $${type} $${pkt-srcaddr} $${pkt-dstaddr} $${region} $${az-id} $${sublocation-type} $${sublocation-id}"
}
