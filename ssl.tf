#bas A wildcard SSL has already been generated and hard-code the ARN.If you are using non AWS DNS
# such as CloudFlaire you do not have to add the following lines. 

# API Custom domain name setup
resource "aws_api_gateway_domain_name" "example" {
  domain_name =  var.new_subdomain
  regional_certificate_arn  =  var.example_cert
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

#  //YOU DO NOT NEED THE FOLLOWING CODES IF YOU WANT TO CREATE A CNAME IN THE CLOUDFLAIRE

# base path mapping
resource "aws_api_gateway_base_path_mapping" "test" {
  api_id      =  aws_api_gateway_rest_api.test.id
  stage_name  =  aws_api_gateway_deployment.test.stage_name
  domain_name =  aws_api_gateway_domain_name.example.domain_name
  base_path   = "info"
}
