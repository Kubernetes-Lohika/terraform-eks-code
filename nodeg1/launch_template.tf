resource "tls_private_key" "deployer" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = var.user-name
  public_key = tls_private_key.deployer.public_key_openssh
}

resource "local_file" "pem_file" {
  filename = pathexpand(format("~/.ssh/%s.pem", var.user-name))
  file_permission = "600"
  directory_permission = "700"
  sensitive_content = tls_private_key.deployer.private_key_pem
}

resource "aws_launch_template" "lt-ng1" {
  instance_type           = "t3.large"
  key_name                = aws_key_pair.deployer.key_name
  name                    = format("at-lt-%s-ng1", var.user-name)
  tags                    = {}
  image_id                = data.aws_ssm_parameter.eksami.value
  user_data            = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids  = [data.terraform_remote_state.net_remote_state.outputs.allnodes-sg]
  tag_specifications { 
        resource_type = "instance"
    tags = {
        Name = format("%s-ng1", data.aws_eks_cluster.eks_cluster.name)
        }
    }
  lifecycle {
    create_before_destroy=true
  }
}


  #block_device_mappings {
  #  device_name = "/dev/sda1"

  #  ebs {
  #    volume_size = 20
  #  }
  #}
 
  
## Enable this when you use cluster autoscaler within cluster.
## https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md

#  tag {
#    key                 = "k8s.io/cluster-autoscaler/enabled"
#    value               = ""
#    propagate_at_launch = true
#  }
#
#  tag {
#    key                 = "k8s.io/cluster-autoscaler/${var.cluster-name}"
#    value               = ""
#    propagate_at_launch = true
#  }



