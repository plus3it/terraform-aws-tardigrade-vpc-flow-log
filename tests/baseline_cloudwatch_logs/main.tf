module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.16.0"

  providers = {
    aws = aws
  }

  name = "tardigrade-vpc-flow-log-testing"
  cidr = "10.0.0.0/16"
}

module "baseline_s3" {
  source = "../../"
  providers = {
    aws = aws
  }

  vpc_id               = module.vpc.vpc_id
  log_destination_type = "cloud-watch-logs"
}
