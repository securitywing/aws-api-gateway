

resource "aws_api_gateway_authorizer" "lambda-apigw-authorizer" {
  name                   = "lambda-apigw-authorizer"
  rest_api_id            =  aws_api_gateway_rest_api.test.id
  authorizer_uri         =  module.lambda-authorizer.lambda-invoke-arn
  type                   = "REQUEST"
  identity_source        =  "method.request.header.prod_header"
}

