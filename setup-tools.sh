echo "Install OS tools"
sudo yum -y -q -e 0 install  jq moreutils bash-completion nmap
echo "update aws cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf aws

echo "Install Terraform"
wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip
unzip -qq terraform_0.15.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm -f terraform_0.15.3_linux_amd64.zip
mkdir -p $HOME/.terraform.d/plugin-cache
cp tf-setup/dot-terraform.rc $HOME/.terraformrc

echo "Install kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl  /usr/local/bin/kubectl
echo "Enable bash_completion"

kubectl completion bash >>  ~/.bash_completion
touch /etc/profile.d/bash_completion.sh

echo "install eksctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv -v /tmp/eksctl /usr/local/bin
echo "eksctl completion"
eksctl completion bash >> ~/.bash_completion
echo "helm"
wget https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -zxf helm-v3.2.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v3.2.1-linux-amd64.tar.gz linux-amd64
echo "add helm repos"
helm repo add eks https://aws.github.io/eks-charts

echo "kubectx"
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

echo "git-remote-codecommit"
sudo pip install git-remote-codecommit

echo "Verify ...."
for command in jq aws wget kubectl terraform eksctl helm kubectx
  do
    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
  done


this=`pwd`
#echo "sample apps"
cd ~/environment
#git clone https://github.com/brentley/ecsdemo-frontend.git
#git clone https://github.com/brentley/ecsdemo-nodejs.git
#git clone https://github.com/brentley/ecsdemo-crystal.git
#git clone https://github.com/aws-samples/aws2tf.git

source ~/.bash_profile

#aws --version
#eksctl version
#Install  version --client
#helm version
#test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set !!
#test -n "$ACCOUNT_ID" && echo ACCOUNT_ID is "$ACCOUNT_ID" || echo ACCOUNT_ID is not set !!

cd ~/environment/tfekscode/lb2
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json -s
cd $this
