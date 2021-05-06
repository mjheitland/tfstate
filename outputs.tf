#-----------
#--- Outputs
#-----------

output "output_s3_bucket_arn" {
  value       = aws_s3_bucket.tf_bucket.arn
  description = "The arn of the s3 bucket that stores terraform's remote state"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.tf_table.arn
  description = "The arn of the dynamodb table that stores the terraform locks"
}
