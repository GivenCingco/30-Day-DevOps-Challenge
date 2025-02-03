
variable "account_id" {
  description = "AWS account ID"
  type        = string
  default     = "009160050878"
}

variable "aws_s3_bucket" {
  type    = string
  default = "given-cingco-rapids"
}

variable "image_repo_name" {
  description = "Image repo name"
  type        = string
  default     = "sports-highlights-repo"
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
  default     = "https://github.com/GivenCingco/30-Day-DevOps-Challenge/tree/main/Week-2-Day-4/src"
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

variable "mediaconvert_endpoint" {
  description = "AWS MediaConvert endpoint"
  type        = string
}

variable "mediaconvert_role_arn" {
  description = "ARN of the MediaConvert IAM role"
  type        = string
}

variable "retry_count" {
  description = "Number of retry attempts for failed operations"
  type        = number
  default     = 5
}

variable "retry_delay" {
  description = "Delay in seconds between retry attempts"
  type        = number
  default     = 60
}