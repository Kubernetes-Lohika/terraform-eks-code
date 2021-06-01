#!/usr/bin/env bash
CONTAINER_NAME="aws-eks-terragrunt-env"
if [[ "$(docker images -q ${CONTAINER_NAME}:latest 2> /dev/null)" == "" ]]; then
  docker build -t ${CONTAINER_NAME} .
fi

docker run -it -v ${PWD}:/root/environment \
              ${CONTAINER_NAME}:latest bash
