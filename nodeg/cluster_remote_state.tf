data "terraform_remote_state" "cluster_remote_state" {
  backend = "s3"
  config = {
    bucket   = "user-terraform-state"
    encrypt  = true
    key      = "cluster/terraform.tfstate"
    region   = "us-east-1"
  }
}