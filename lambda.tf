data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/"
  output_path = ".terraform/terraform-alb-logs-cloudwatch/lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  description      = "Reads ALB logs and sends them to CloudWatch Logs."
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  runtime          = "nodejs10.x"
  timeout          = 10

  environment {
    variables = {
      LOG_GROUP_NAME  = var.log_group_name
      LOG_STREAM_NAME = var.log_stream_name
    }
  }
}

resource "aws_lambda_permission" "allow_lambda_invocation" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.log_bucket_id}"
}
