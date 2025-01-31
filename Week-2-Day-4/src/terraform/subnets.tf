# Fetch all subnets in the default VPC
data "aws_subnets" "default_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Extract two public subnets in different availability zones
data "aws_subnet" "az1" {
  id = tolist(data.aws_subnets.default_public.ids)[0]
}

data "aws_subnet" "az2" {
  id = tolist(data.aws_subnets.default_public.ids)[1]
}