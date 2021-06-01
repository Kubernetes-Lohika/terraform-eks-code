data "terraform_remote_state" "net_remote_state" {
  backend = "s3"
  config = {
    bucket   = "user-terraform-state"
    encrypt  = true
    key      = "net/terraform.tfstate"
    region   = "us-east-1"
  }
}