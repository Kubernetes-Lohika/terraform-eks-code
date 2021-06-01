FROM centos:8

WORKDIR /root/environment

COPY . .
RUN yum install -y sudo unzip jq bash wget
RUN mkdir -p /root/environment/.aws && ln -s /root/environment/.aws /root/.aws
RUN /root/environment/setup-tools.sh
