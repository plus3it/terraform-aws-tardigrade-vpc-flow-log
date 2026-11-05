# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates an AWS VPC Flow Log for one source: a network interface, subnet, transit gateway, transit gateway attachment, or VPC. Everything is set through the single `flow_log` object input, which needs `name` and `log_destination_type`. For `cloud-watch-logs` destinations, the module also creates a CloudWatch log group (unless `cloudwatch_log_group.enable` is false) and an IAM role (unless `iam_role_arn` is set). The module outputs `flow_log`, `cloudwatch_log_group`, and `iam_role`.
