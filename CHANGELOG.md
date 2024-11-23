## terraform-aws-tardigrade-vpc-flow-log Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### [3.0.1](https://github.com/plus3it/terraform-aws-tardigrade-vpc-flow-log/releases/tag/3.0.1)

**Released**: 2024.11.22

**Summary**:

*   Moves iam role conditions to trust policy instead of role policy, per aws guidance
    for mitigating confused deputy problem. See also:
    *   https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-iam-role.html
    *   https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html

### [3.0.0](https://github.com/plus3it/terraform-aws-tardigrade-vpc-flow-log/releases/tag/3.0.0)

**Released**: 2024.11.20

**Summary**:

*   Refactors module to support all attributes of the Flow Log resource
*   Supported sources include:
    * VPC ID
    * Subnet ID
    * Transit Gateway ID
    * Transit Gateway Attachment ID
    * Elastic Network Interface ID
*   Supported destination types include:
    * CloudWatch Log Group
    * S3 Bucket
    * Kinesis Data Firehose
*   When the destination type is a CloudWatch Log Group, the module supports either
    creating the log group, or providing the log group arn via the `log_destination`
    input. For other destination types, the `log_destination` is required.

### 1.0.2

**Released**: 2019.10.28

**Commit Delta**: [Change from 1.0.1 release](https://github.com/plus3it/terraform-aws-tardigrade-vpc-flow-log/compare/1.0.1...1.0.2)

**Summary**:

*   Pins tfdocs-awk version
*   Updates documentation generation make targets
*   Adds documentation to the test modules
*   Minor changelog fixup

### 1.0.1

**Released**: 2019.10.04

**Commit Delta**: [Change from 1.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-vpc-flow-log/compare/1.0.0...1.0.1)

**Summary**:

*   Update testing harness to have a more user-friendly output
*   Update terratest dependencies

### 1.0.0

**Released**: 2019.09.11

**Commit Delta**: [Change from 0.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-vpc-flow-log/compare/0.0.0...1.0.0)

**Summary**:

*   Upgrade to terraform 0.12.x
*   Add test cases

### 0.0.0

**Commit Delta**: N/A

**Released**: 2019.08.21

**Summary**:

*   Initial release!
