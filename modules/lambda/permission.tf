resource "aws_lambda_permission" "post_session_trigger" {
     statement_id  = "Allow__Post_Session_Invoke"
     action        = "lambda:InvokeFunction"
     function_name =  var.LAMBDA_FUNCTION_NAME
     principal     = "apigateway.amazonaws.com"
     #source_arn   = "arn:aws:execute-api:eu-west-1:accdount-d:api-gateway-id/authorizers/authorizer-id" 
     source_arn    =  var.LAMBDA_SOURCE_ARN
}
