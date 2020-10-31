# File generated by aws2tf see https://github.com/awsandy/aws2tf
# aws_eks_node_group.mycluster1_ng-maneksami2:
resource "aws_eks_node_group" "mycluster1_ng-maneksami2" {
  ami_type       = "AL2_x86_64"
  #depends_on     = [data.terraform_remote_state.cluster.aws_eks_cluster.mycluster1]
  cluster_name   = "mycluster1"
  disk_size      = 0
  instance_types = []
  labels = {
    "alpha.eksctl.io/cluster-name"   = "mycluster1"
    "alpha.eksctl.io/nodegroup-name" = "ng-maneksami2"
  }
  node_group_name = "ng-maneksami2"
  node_role_arn   = data.terraform_remote_state.iam.outputs.nodegroup_role_arn
  release_version = "1.17.11-20201007"
  subnet_ids = [
      data.terraform_remote_state.net.outputs.sub-priv1,
      data.terraform_remote_state.net.outputs.sub-priv2,
      data.terraform_remote_state.net.outputs.sub-priv3,
  ]
  tags = {
    "alpha.eksctl.io/cluster-name"                = "mycluster1"
    "alpha.eksctl.io/eksctl-version"              = "0.29.2"
    "alpha.eksctl.io/nodegroup-name"              = "ng-maneksami2"
    "alpha.eksctl.io/nodegroup-type"              = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "mycluster1"
  }
  version = "1.17"

  launch_template {
    name    = aws_launch_template.lt-001c97f607e636908.name
    version = "1"
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  timeouts {}
}
