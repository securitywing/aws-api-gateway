# Role 
resource "aws_iam_role" "api_gateway_lambda_authorizer" {
  name = "api_gateway_lambda_authorizer"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "events.amazonaws.com",
          "apigateway.amazonaws.com"
           ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
# Role ends

# Attach the Policy to the role
resource "aws_iam_role_policy_attachment" "policy-attach" {
      role       =  aws_iam_role.api_gateway_lambda_authorizer.name
      policy_arn =  aws_iam_policy.api_gateway_lambda_authorizer_policy.arn
}
# Policy attachment ends

# Lambda function
resource "aws_lambda_function" "api_gateway_authorizer_lambda" {
  filename      = "lambda-authorizer.zip"
  function_name =  var.LAMBDA_FUNCTION_NAME
  role          =  aws_iam_role.api_gateway_lambda_authorizer.arn
  handler       =  "lambda-authorizer.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  # source_code_hash = "${filebase64sha256("lambda-authorizer.zip")}"
 source_code_hash = "./${filebase64sha256("lambda-authorizer.zip")}"
  runtime = "nodejs10.x"

  environment {
    variables = {
     # change the header value from the Lambda console and enable encrytpion in transit. At the 
     # moment terraform does not support kms encryption-in-transit for Lambda.
      secret = "dummy-header"
    }
  }
  
}

# Lambda function ends
