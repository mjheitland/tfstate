variable "project" {
  type        = string
  description = "Name of the project whose TF state we want to store."
}

variable "region" {
  type        = string
  description = "AWS region where the resources should be deployed to."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for our VPC"
}