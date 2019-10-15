# TF-AWS-ALB-Logs-CloudWatch

A Module to shift ALB logs from their default S3 location in to a CloudWatch Log Group

## Example

```hcl
module "alb_logs" {
  source = "./localmodules/terraform-alb-logs-cloudwatch"

  name            = "alb-logs"
  log_group_name  = var.alb_log_group_name
  log_stream_name = var.alb_log_stream_name
  log_bucket_id   = var.access_logs_bucket_id
  log_retention   = var.log_retention
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | Name of the resources this module creates | string |  | yes |
| log_group_name | Name of the log group to create the log stream in | string |  | yes |
| log_stream_name | Name of the log stream to create | string |  | yes |
| log_bucket_id | Name of the bucket to retrieve logs | string |  | yes |
| log_retention | Log expiry time in days | string | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn | Lambda Function ARN |
