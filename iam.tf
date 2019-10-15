data "aws_iam_policy_document" "lambda" {
  statement {
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.log_bucket_id}/*"]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:*"]

    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:${var.log_group_name}:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:${aws_cloudwatch_log_group.lambda.name}:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_role" "lambda" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda" {
  name   = var.name
  path   = "/"
  policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}
