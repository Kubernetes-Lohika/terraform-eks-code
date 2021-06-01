data "terraform_remote_state" "iam_remote_state" {
  backend = "s3"
  config = {
    bucket   = "user-terraform-state"
    encrypt  = true
    key      = "iam/terraform.tfstate"
    region   = "us-east-1"
  }
}