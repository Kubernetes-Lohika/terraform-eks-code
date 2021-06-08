# stage/terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "test-doh6alei-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "test-table"
    profile = "default"
  }
}
inputs = {
  user-name  = "test-test"
  aws_region = "us-east-1"
  aws_profile = "default"
}
