# IAM policy
 resource "aws_iam_policy" "api_gateway_lambda_authorizer_policy" {
     name        = "api_gateway_lambda_authorizer_policy"
     description = "AWS API gateway Lambda Authorizer  policy"
     policy      =  file("${path.module}/policy.json")

}
#IAM polciy ends
