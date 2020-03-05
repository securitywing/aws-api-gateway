resource "aws_api_gateway_stage" "test" {
  stage_name    =  var.stage_name
  rest_api_id   =  aws_api_gateway_rest_api.test.id
  deployment_id =  aws_api_gateway_deployment.test.id
}

resource "aws_api_gateway_rest_api" "test" {
  name        =  var.gateway_name
  description = "This is my API for demonstration purposes"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}


# Stage name after deployment.
resource "aws_api_gateway_deployment" "test" {
  depends_on  = [aws_api_gateway_integration.test]
  rest_api_id =  aws_api_gateway_rest_api.test.id
  stage_name  =  var.deployed_stage_name
}


# v1 path
resource "aws_api_gateway_resource" "test" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  parent_id   =  aws_api_gateway_rest_api.test.root_resource_id
  path_part   = "v1"
 # path_part   = "{proxy+}"
}

# info- a dummy resource
resource "aws_api_gateway_resource" "info" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  parent_id   =  aws_api_gateway_resource.test.id
  path_part   = "test"
}

# route
resource "aws_api_gateway_resource" "route" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  parent_id   =  aws_api_gateway_resource.info.id
  path_part   = "route"
}


# method v1
resource "aws_api_gateway_method" "test" {
  rest_api_id   =  aws_api_gateway_rest_api.test.id
  resource_id   =  aws_api_gateway_resource.test.id
  http_method   = "GET"
  authorization = "NONE"
}

# method info
resource "aws_api_gateway_method" "info" {
  rest_api_id   =  aws_api_gateway_rest_api.test.id
  resource_id   =  aws_api_gateway_resource.info.id
  http_method   = "GET"
  authorization = "NONE"
}

# method route
resource "aws_api_gateway_method" "route" {
  rest_api_id   =  aws_api_gateway_rest_api.test.id
  resource_id   =  aws_api_gateway_resource.route.id
  http_method   = "GET"
 # authorization = "NONE"
 authorization   = "CUSTOM"
 authorizer_id  =   aws_api_gateway_authorizer.lambda-apigw-authorizer.id
}

# Method Response for route
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  resource_id =  aws_api_gateway_resource.route.id
  http_method =  aws_api_gateway_method.route.http_method
  status_code = "200"
  response_models =  {
           "application/json" : "Empty"
  }

response_parameters = {
    "method.response.header.Access-Control-Allow-Headers": true,
    "method.response.header.Access-Control-Allow-Methods": true,
    "method.response.header.Access-Control-Allow-Origin": true
}

}


# Method Settings
resource "aws_api_gateway_method_settings" "s" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  stage_name  =  aws_api_gateway_stage.test.stage_name
 # method_path = "${aws_api_gateway_resource.test.path_part}/${aws_api_gateway_method.test.http_method}"
 method_path = "*/*"
  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

# turn on logging for stage_1
resource "aws_api_gateway_method_settings" "s2" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  #stage_name  = aws_api_gateway_stage.test.stage_name
  stage_name   = aws_api_gateway_deployment.test.stage_name
  method_path = "*/*"
  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

# Integration for V1
resource "aws_api_gateway_integration" "test" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  resource_id =  aws_api_gateway_resource.test.id
  http_method =  aws_api_gateway_method.test.http_method
  type                    = "HTTP_PROXY"
  uri                     = var.URI_NAME
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  content_handling        = "CONVERT_TO_TEXT"
  }
# Integration for INFO resource
resource "aws_api_gateway_integration" "info" {
  rest_api_id = aws_api_gateway_rest_api.test.id
  resource_id = aws_api_gateway_resource.info.id
  http_method = aws_api_gateway_method.info.http_method
  type                    = "HTTP_PROXY"
  uri                    =   var.URI_NAME
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  content_handling        = "CONVERT_TO_TEXT"
  }



# Integration for route
resource "aws_api_gateway_integration" "route" {
  rest_api_id =  aws_api_gateway_rest_api.test.id
  resource_id =  aws_api_gateway_resource.route.id
  http_method =  aws_api_gateway_method.route.http_method
  type                    = "HTTP_PROXY"
  uri                     = var.URI_NAME
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  content_handling        = "CONVERT_TO_TEXT"
  }


# CloudWatch Log Group
variable "log_stage_name" {
  default = "prod1"
  type    =  string
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.test.id}/${var.log_stage_name}"
  retention_in_days = 7
}
