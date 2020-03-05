variable "AWS_REGION" {
   default = "eu-west-1"
}

variable "lambda-function-name" {
     default = "api_gateway_header_authorizer_function"
   }

variable "URI_NAME" {
     default = "https://api-test.sixthgalaxy.com/message"
   }

variable "new_subdomain" {
    default = "api-test.sixthgalaxy.com"
}

variable "stage_name" {
     default = "production"
        }


variable "gateway_name" {
     default = "api-test.sixthgalaxy.com"
    }

variable "deployed_stage_name" {
    default = "prod-stage"
    }

# SSL ARN
variable "example_cert" {
   default = "arn:aws:acm:eu-west-1:607281769355:certificate/62c3b8ef-5fac-4adf-8ab2-a9539b17364c"
 }
variable "hosted_zone_id" {
     default = ""
}

# source arn format "arn:aws:execute-api:eu-west-1:account_id:api-gateway-id/authorizers/authorizer-id"
#variable "lambda-source-arn" {
#   default = "arn:aws:execute-api:eu-west-1:607281769355:lr72e38nvc/authorizers/h2bqn8"
#}
