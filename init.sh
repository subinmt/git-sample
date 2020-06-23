#!/bin/bash
d=`date +%F`
sudo adduser jenkins$d

sudo cd /home/jenkins$d

#To get kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version --client



wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 -O heptio-authenticator-aws

chmod +x heptio-authenticator-aws

sudo mv heptio-authenticator-aws /usr/local/bin/

heptio-authenticator-aws help

#Terraform output from kubeconfig
#terraform output kubeconfig

#Terraform exporting configmap YAML file
#terraform output config-map-aws-auth

#terraform output kubeconfig > ~/.kube/config
#terraform output config-map-aws-auth > aws-auth.yaml
#kubectl apply -f aws-auth.yaml
