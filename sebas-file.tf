# VPC
resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.namespace
    Namespace = var.namespace
  }
}
