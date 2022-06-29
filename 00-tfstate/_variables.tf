variable "project" {
  type        = string
  description = "(Optional) Name of the project whose TF state we want to store."
  default     = "tfstateprj"
}

variable "kms_key_id" {
  type        = string
  description = "(Optional) The ID of the KMS key to use to encrypt the bucket. If not specified, AES256 encryption will be used."
  default     = null
}


locals {
  account = data.aws_caller_identity.current.account_id
  region  = data.aws_region.current.id
  bucket  = "tfstate-${var.project}-${local.account}-${local.region}"
  table   = "tfstate-${var.project}-${local.region}"
}
