# TODO: Define the variable for aws_region
# AWS region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}



# S3 Bucket to store Lambda code
variable "lambda_bucket_name" {
  description = "The name of the S3 bucket to store Lambda code"
  default     = "hassan-terraform-bucket-2025" # Ensure this name follows the S3 naming rules
}

# Lambda function name
variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default     = "ExampleLambda"
}
