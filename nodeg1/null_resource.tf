resource "null_resource" "gen_cluster_auth" {
triggers = {
    always_run = timestamp()
}

provisioner "local-exec" {
    on_failure  = fail
    when = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[32m Testing Network Connectivity ${data.aws_eks_cluster.eks_cluster.name}...should see port 443/tcp open  https\x1B[0m"
        ./test.sh ${data.aws_eks_cluster.eks_cluster.name}
        echo -e "\x1B[32m Checking Authorization ${data.aws_eks_cluster.eks_cluster.name}...should see Server Version: v1.18.xxx \x1B[0m"
        ./auth.sh ${data.aws_eks_cluster.eks_cluster.name}
        echo "************************************************************************************"
     EOT
}
}

  