# tfstate

The code in `00-tfstate` creates an S3 bucket to store Terraform's remote state and it creates a DynamoDB table to keep a lock for synchronizing TF's deployments.

## S3 backend (from Terraform's documentation)

```text
The S3 backend stores the state as a given key in a given bucket on Amazon S3. This backend also supports state locking and consistency checking via Dynamo DB, which can be enabled by setting the dynamodb_table field to an existing DynamoDB table name. A single DynamoDB table can be used to lock multiple remote state files. Terraform generates key names that include the values of the bucket and key variables.

Warning! It is highly recommended that you enable Bucket Versioning on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.
```

## Encryption of the State file

You can use a Customer managed KMS key to encrypt the state file (if CMK is not set, it uses the default KMS key).

## Example Usage

`10-network` serves as a simple example of deploying a VPC in 10-network using S3/DynamoDB as a remote backend.

## Deploy 00_tfstate

```terraform
# If you want to save TF state for 00_tfstate,
# remove the comments for the backend in providers.tf and run the init command a second time.
terraform init

# To prevent accidental deletion of this bucket,
# change `force_destroy` to `false` and `prevent_destroy` to `true` in `tfstate.tf`
terraform apply -auto-approve

# WARNING: if you delete this bucket the corresponding project might loose all its TF state files
# Manually in AWS Console: delete all bucket objects (included versioned ones)
# temporarily change `force_destroy` to `true` and `prevent_destroy` to `false` in `tfstate.tf`
terraform destroy -auto-approve
```

## Deploy 10_network

```terraform
terraform init -backend-config=../backend.config
terraform apply -auto-approve
terraform destroy -auto-approve
```
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.sftp_bucket_block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ID of the KMS key to use to encrypt the bucket. If not specified, AES256 encryption will be used. | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project whose TF state we want to store. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the resources should be deployed to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | The arn of the dynamodb table that stores the terraform locks |
| <a name="output_output_s3_bucket_arn"></a> [output\_s3\_bucket\_arn](#output\_output\_s3\_bucket\_arn) | The arn of the s3 bucket that stores terraform's remote state |
