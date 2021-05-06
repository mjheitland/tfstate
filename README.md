# tfstate

Create S3 bucket to store Terraform's remote state and create a DynamoDB table to keep a lock for synchronizing TF's deployments.

```
terraform init

terraform apply -auto-approve

terraform destroy -auto-approve
```
