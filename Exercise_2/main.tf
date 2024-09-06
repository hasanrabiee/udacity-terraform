# Specify the provider
provider "aws" {
  region = var.aws_region
  access_key = "AKIATHJJSFQB3VBXPB5O"
  secret_key = "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"
}

# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for logging to CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create S3 bucket to upload lambda code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.lambda_bucket_name
}

# Upload the lambda code (python file) to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "greet_lambda.zip"
  source = "greet_lambda.zip"
}

# Lambda Function
resource "aws_lambda_function" "example_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.8"
  
  s3_bucket     = aws_s3_bucket.lambda_bucket.bucket
  s3_key        = aws_s3_object.lambda_code.key

  environment {
    variables = {
      MESSAGE = "Hello from Terraform!"
    }
  }
}

# Lambda CloudWatch Event Trigger (manual testing)
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.example_lambda.function_name}"
  retention_in_days = 7
}

