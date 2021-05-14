provider "aws" {}

locals {
  layer_name = "lambda-layer-terraform"
}

data "aws_lambda_layer_version" "this" {
  layer_name = local.layer_name
}

resource "aws_iam_role" "this" {
  name = "lambda-layer-terraform-sample"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "function"
  output_path = "function.zip"
}

resource "aws_lambda_function" "this" {
  function_name     = "lambda-layer-terraform-sample"
  filename          = data.archive_file.this.output_path
  source_code_hash  = filebase64sha256(data.archive_file.this.output_path)
  handler           = "function.apply"
  role              = aws_iam_role.this.arn
  runtime           = "provided"
  timeout           = 60
  layers            = [data.aws_lambda_layer_version.this.arn]
}