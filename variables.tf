#---------------------------
#--- tfvariables.tf - Inputs
#---------------------------
variable "project" {
  description = "Project name is used as namespace for Terraform remote state and other resources."
  type        = string
}

variable "region" {
  description = "AWS region we are deploying to"
  type        = string
}

variable "bucket" {
  description = "S3 bucket to store TF remote state"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table to store TF remote state lock"
  type        = string
}
