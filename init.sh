#!/bin/bash
d=`date +%F%H%M`
sudo adduser jenkins$d

sudo cd /home/jenkins$d

#To get kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$1".0/bin/linux/amd64/kubectl

chmod +x ./kubectl

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

kubectl version --short --client



wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 -O heptio-authenticator-aws

chmod +x heptio-authenticator-aws

mkdir -p $HOME/bin && cp ./heptio-authenticator-aws $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

heptio-authenticator-aws help


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
#terraform output kubeconfig

#Terraform exporting configmap YAML file
#terraform output config-map-aws-auth

#terraform output kubeconfig > ~/.kube/config
#terraform output config-map-aws-auth > aws-auth.yaml
#kubectl apply -f aws-auth.yaml
