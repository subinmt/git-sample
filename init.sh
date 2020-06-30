#!/bin/bash
d=`date +%F%H%M`
sudo adduser jenkins$d

#To get kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$1".0/bin/linux/amd64/kubectl

sudo chmod +x ./kubectl

sudo mkdir -p /home/jenkins$d/bin && sudo mv ./kubectl /home/jenkins$d/bin/kubectl && export PATH=$PATH:/home/jenkins$d/bin

kubectl version --short --client

echo "Kubectl Installed"


wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 -O heptio-authenticator-aws

sudo chmod +x heptio-authenticator-aws

sudo mv ./heptio-authenticator-aws /home/jenkins$d/bin/heptio-authenticator-aws && export PATH=$PATH:/home/jenkins$d/bin

heptio-authenticator-aws help

echo "aws-heptio-authenticator Installed"


if [ $2 == "dev" ]
then
    echo "Dev"
    sed -i 's|REPLACEME|arn:aws:iam::861112368680:role/worker-nodes-role|g' config-map-aws-auth.yaml
 
elif [ $2 == "pprod" ]
then
    echo "Preprod"
    sed -i 's|REPLACEME|arn:aws:iam::861112368680:role/worker-nodes-role2|g' config-map-aws-auth.yaml

else
    echo "Prod"
    sed -i 's|REPLACEME|arn:aws:iam::861112368680:role/worker-nodes-role3|g' config-map-aws-auth.yaml
fi


#Terraform output from kubeconfig
terraform output kubeconfig

#terraform output kubeconfig > /home/jenkins$d/.kube/config

#Deploying config-map for join worker nodes.
#/home/jenkins$d/bin/kubectl create -f config-map-aws-auth.yaml
