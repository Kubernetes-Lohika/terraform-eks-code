# stage/terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "user-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "user-table"
    profile = "default"
  }
}
inputs = {
  cluster-name  = "k8s-user"
  aws_region = "us-east-1"
  aws_profile = "default"
}
