provider aws {
  region = "us-east-1"
}

module "baseline_s3" {
  source = "../../"
  providers = {
    aws = aws
  }

  create_vpc_flow_log = false
}
