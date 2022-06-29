# tfstate

Create S3 bucket to store Terraform's remote state and create a DynamoDB table to keep a lock for synchronizing TF's deployments.

You can use a Customer managed KMS key to encrypt the state file (if CMK is not set, it uses the default KMS key.

```terraform
terraform init

terraform apply -auto-approve

# WARNING: if you delete this bucket the corresponding project might loose all its TF state files!
# Pre-requisites: delete all bucket objects (included versioned ones) in AWS Console,
# temporarily change `force_destroy` to `true` and `prevent_destroy` to `false`.
terraform destroy -auto-approve
```
