```
terraform init
terraform plan -var-file="../../terraform.tfvars"
terraform apply -var-file="../../terraform.tfvars" -auto-approve
terraform destroy -var-file="../../terraform.tfvars" -auto-approve
terraform plan -destroy -var-file="../../terraform.tfvars"
```