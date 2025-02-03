module "LoadBalancerSG" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Security group for Load balancer"
  description = "Security group for my EC2 with HTTP and SSH ports open within VPC"
  vpc_id      = data.aws_vpc.default.id

  /*===Inbound Rules===*/
  ingress_with_cidr_blocks = [


    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP outbound traffic"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP outbound traffic"
    },
     {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP outbound traffic"
    }
  ]

  /*===Outbound Rules===*/
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

}

output "security_group_id" {
  value = module.LoadBalancerSG.security_group_id
}