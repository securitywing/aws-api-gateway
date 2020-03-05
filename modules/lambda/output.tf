output "lambda-arn"  {
        value = "${aws_lambda_function.api_gateway_authorizer_lambda.arn}"
}

output "lambda-invoke-arn"  {
        value = "${aws_lambda_function.api_gateway_authorizer_lambda.invoke_arn}"
}

