
variable "account_id" {
  description = "AWS account ID"
  type        = string
  default = "009160050878"
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


# variable "github_url" {
#   description = "source of the buildpec file on GitHub "
#   type        = string
#   default     = "https://github.com/givencingco-bitcube/karmah-web-main-copy"
# }
