data "aws_lambda_function" "lambda-function-name" {
  function_name = "${var.lambda-function-name}"
  depends_on = [module.lambda-authorizer.lambda-arn]
}

module "lambda-authorizer" {
  source = "./modules/lambda"
  LAMBDA_FUNCTION_NAME = "${var.lambda-function-name}"
 # LAMBDA_SOURCE_ARN    = "${var.lambda-source-arn}"
  LAMBDA_SOURCE_ARN     = "arn:aws:execute-api:eu-west-1:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.test.id}/authorizers/${aws_api_gateway_authorizer.lambda-apigw-authorizer.id}"	
  LAMBDA_REGION        = "${var.AWS_REGION}"
 }
