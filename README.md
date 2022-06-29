# tfstate

Create S3 bucket to store Terraform's remote state and create a DynamoDB table to keep a lock for synchronizing TF's deployments.

You can use a Customer managed KMS key to encrypt the state file (if CMK is not set, it uses the default KMS key.

Then you will use bucket and table as a remote backend, here we have an example of deploying a VPC in 10-network.

## Deploy 00_tfstate

```terraform
# If you want to save TF state for 00_tfstate, run the commands twice
# and remove the comments for the backend in providers.tf

terraform init
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
