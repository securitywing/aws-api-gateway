output "Stage_Name" {
  value =  "${aws_api_gateway_stage.test.stage_name}"

}


output "Deployed_Stage_Name" {
   value = "${aws_api_gateway_deployment.test.stage_name}"
 
}


output "lambda-arn" {
   value = "${module.lambda-authorizer.lambda-arn}"
 }

output "lambda-invoke-arn" {
   value = "${module.lambda-authorizer.lambda-invoke-arn}"
}
#output "lambda-authorizer-function-name" {
#   value = "${data.aws_lambda_function.lambda-function-name}"
#}

output "authorizer-id" {
      value = "${aws_api_gateway_authorizer.lambda-apigw-authorizer.id}" 
 }

output "api-gateway-id" {
    value  = "${aws_api_gateway_rest_api.test.id}" 
 }

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "lambda-full-arn" {
  value = "arn:aws:execute-api:eu-west-1:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.test.id}/authorizers/${aws_api_gateway_authorizer.lambda-apigw-authorizer.id}"
}
