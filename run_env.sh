#!/usr/bin/env bash

if [[ "$(docker images -q aws-eks-env:latest 2> /dev/null)" == "" ]]; then
  docker build -t aws-eks-env .
fi

docker run -it -v ${PWD}:/root/environment aws-eks-env:latest bash
