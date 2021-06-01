resource "aws_eks_cluster" "cluster" {
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
  name       = var.cluster-name
  
  role_arn   = data.terraform_remote_state.iam_remote_state.outputs.cluster_service_role_arn
  tags       = {}
  version    = "1.18"

  timeouts {}

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = [
      data.terraform_remote_state.net_remote_state.outputs.cluster-sg,
    ]
    subnet_ids = [
      data.terraform_remote_state.net_remote_state.outputs.sub-pub1,
      data.terraform_remote_state.net_remote_state.outputs.sub-pub2,
      data.terraform_remote_state.net_remote_state.outputs.sub-pub3,
    ]
  }
}

output cluster-name {
  value=aws_eks_cluster.cluster.name
}

output cluster-sg {
  value=aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

output ca {
  value=aws_eks_cluster.cluster.certificate_authority[0].data
}

output endpoint {
  value=aws_eks_cluster.cluster.endpoint
}