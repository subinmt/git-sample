#!/bin/bash
d=`date +%F%H%M`
sudo adduser jenkins$d

#To get kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v"$1".0/bin/linux/amd64/kubectl

sudo chmod +x ./kubectl

sudo mkdir -p /home/jenkins$d/bin && sudo mv ./kubectl /home/jenkins$d/bin/kubectl && sudo chmod -R 755 /home/jenkins$d/ && export PATH=$PATH:/home/jenkins$d/bin

kubectl version --short --client

echo "Kubectl Installed"


wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 -O heptio-authenticator-aws

sudo chmod +x heptio-authenticator-aws

sudo mv ./heptio-authenticator-aws /home/jenkins$d/bin/heptio-authenticator-aws && export PATH=$PATH:/home/jenkins$d/bin

sudo chown -R jenkins$d.jenkins$d /home/jenkins$d/bin/

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

sudo mkdir -p /home/jenkins$d/.kube
sudo terraform output kubeconfig > config-1
sudo mv config-1 /home/jenkins$d/.kube/config && sudo chown -R jenkins$d.jenkins$d /home/jenkins$d/.kube/

#Deploying config-map for join worker nodes.
sudo mv config-map-aws-auth.yaml /home/jenkins$d/config-map-aws-auth.yaml

#sudo -H -u jenkins$d bash -c 'echo 'export PATH=$PATH:/home/jenkins$d/bin' >> /home/jenkins$d/.bashrc'
#sudo -H -u jenkins$d bash -c '/home/jenkins$d/bin/kubectl create -f /home/jenkins$d/config-map-aws-auth.yaml'

sudo su -l -p jenkins$d

echo 'export PATH=$PATH:/home/jenkins$d/bin' >> /home/jenkins$d/.bashrc
source ~/.bashrc
/home/jenkins$d/bin/kubectl create -f /home/jenkins$d/config-map-aws-auth.yaml
