data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket_public_access_block" "sftp_bucket_block_public_access" {
  bucket = aws_s3_bucket.tfstate.id

  # Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false.
  # Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to:
  # Reject calls to PUT Bucket policy if the specified bucket policy allows public access.
  block_public_acls = true

  # Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false.
  # Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to:
  # Reject calls to PUT Bucket policy if the specified bucket policy allows public access.
  block_public_policy = true

  # Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false.
  # Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to:
  # Ignore public ACLs on this bucket and any objects that it contains.
  ignore_public_acls = true

  # Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false.
  # Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy,
  # including non-public delegation to specific accounts, is blocked. When set to true:
  # Only the bucket owner and AWS Services can access this buckets if it has a public policy.
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  acl    = "private" # Owner gets FULL_CONTROL. No one else has access rights (default).
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id != null ? var.kms_key_id : null
      sse_algorithm     = var.kms_key_id == null ? "AES256" : "aws:kms"
    }
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = local.bucket

  # A boolean that indicates all objects (including any locked objects) should be deleted from the bucket
  # so that the bucket can be destroyed without error. These objects are not recoverable!
  force_destroy = true

  # prevent accidental deletion of this bucket
  # (if you really have to destroy this bucket, change this value to false and reapply, then run destroy)
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "tfstate" {
  name         = local.table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
