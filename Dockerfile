FROM centos:8

WORKDIR /root/environment

COPY . .
RUN yum install -y sudo unzip jq bash wget
RUN /root/environment/setup-tools.sh
