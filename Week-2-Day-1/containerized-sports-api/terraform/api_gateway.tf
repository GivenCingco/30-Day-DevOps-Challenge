resource "aws_api_gateway_rest_api" "Sports_API" {
  name        = "Sports API"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "Sports_API_resource" {
  rest_api_id = aws_api_gateway_rest_api.Sports_API.id
  parent_id   = aws_api_gateway_rest_api.Sports_API.root_resource_id
  path_part   = "sports"
}

resource "aws_api_gateway_method" "Sports_API_method" {
  rest_api_id   = aws_api_gateway_rest_api.Sports_API.id
  resource_id   = aws_api_gateway_resource.Sports_API_resource.id
  http_method   = "GET"
  authorization = "NONE"
}


# Integrate the GET method with the load balancer
resource "aws_api_gateway_integration" "sports_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.Sports_API.id
  resource_id             = aws_api_gateway_resource.Sports_API_resource.id
  http_method             = aws_api_gateway_method.Sports_API_method.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_lb.app_lb.dns_name}/sports" # Replace with your ALB DNS name

}

# Deploy the API
resource "aws_api_gateway_deployment" "sports_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.Sports_API.id

  depends_on = [
    aws_api_gateway_method.Sports_API_method,
    aws_api_gateway_integration.sports_get_integration
  ]
}

# Create a stage for the deployment
resource "aws_api_gateway_stage" "sports_api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.Sports_API.id
  deployment_id = aws_api_gateway_deployment.sports_api_deployment.id
  stage_name    = "Dev" 
}


# Output the API Gateway URL
output "api_gateway_url" {
  value = "${aws_api_gateway_deployment.sports_api_deployment.invoke_url}/sports"
}