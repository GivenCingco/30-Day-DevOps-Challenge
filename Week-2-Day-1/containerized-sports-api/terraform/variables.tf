
variable "account_id" {
  description = "AWS account ID"
  type        = string
  default     = "009160050878"
}


variable "image_repo_name" {
  description = "Image repo name"
  type        = string
  default     = "sports-api-repo"
}

variable "image_tag" {
  description = "Image tag"
  type        = string
  default     = "latest"
}


variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}


variable "github_url" {
  description = "source of the buildpec file on GitHub "
  type        = string
  default     = "https://github.com/GivenCingco/30-Day-DevOps-Challenge/tree/main/Week-2-Day-1/containerized-sports-api"
}

variable "codestart_connector_cred" {
  type        = string
  default     = "arn:aws:codeconnections:us-east-1:009160050878:connection/e45787a2-fc5d-453f-a71f"
  description = "Variable for CodeStar connection credentials"

}

variable "api_key" {
  description = "The API key for the service"
  type        = string
}
