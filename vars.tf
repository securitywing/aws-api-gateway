variable "AWS_REGION" {
   default = "eu-west-1"
}

variable "lambda-function-name" {
     default = "api_gateway_header_authorizer_function"
   }

variable "URI_NAME" {
     default = "https://api-test.yourdomain.com/message"
   }

variable "new_subdomain" {
    default = "api-test.yourdomain.com"
}

variable "stage_name" {
     default = "production"
        }


variable "gateway_name" {
     default = "api-test.yourdomain.com"
    }

variable "deployed_stage_name" {
    default = "prod-stage"
    }

# SSL ARN - ARN of the SSL stored in ACM
variable "example_cert" {
   default = ""
 }
variable "hosted_zone_id" {
     default = ""
}

