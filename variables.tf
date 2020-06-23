variable "env" {}

variable "env_vpc" {
  type = map(string)
  default = {
    dev     = "dev"
    pprod   = "pre-prod"
    prod    = "prod"
  }
}

variable "security_group_ids" {
  type = map
  default = {
    dev     = ["sg-0ea00f5503f8095d6"]
    pprod   = ["sg-0ea00f5503f8095d6"]
    prod    = ["sg-0ea00f5503f8095d6"]
  }
}

variable "sg_wrk_nodes_ids" {
  type = map
  default = {
    dev     = ["sg-08abb466319b6f316", "sg-054fa00351b36ce25"]
    pprod   = ["sg-08abb466319b6f316", "sg-054fa00351b36ce25"]
    prod    = ["sg-08abb466319b6f316", "sg-054fa00351b36ce25"]
  }
}

variable "iam_cluster_role" {
  type = map
  default = {
    dev     = "arn:aws:iam::861112368680:role/MyEKS-Role"
    pprod   = "arn:aws:iam::861112368680:role/MyEKS-Role"
    prod    = "arn:aws:iam::861112368680:role/MyEKS-Role"
  }
}

variable "cluster_name" {
  default = ""
  type = string
}

variable "cluster_version" {
  default = ""
  type = string
}

#map from environment to the type of EC2 instance

variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    preprod = "m5.xlarge"
    prod  = "m5.xlarge"
  }
}


# Autoscaling group node count for each environments

variable "asg_desired" {
  type = map(string)
  default = {
    dev     = "2"
    pprod   = "4"
    prod    = "3"
  }
}

variable "asg_min" {
  type = map(string)
  default = {
    dev     = "1"
    pprod   = "2"
    prod    = "1"
  }
}

variable "asg_max" {
  type = map(string)
  default = {
    dev     = "2"
    pprod   = "9"
    prod    = "4"
  }
}

variable "aws_iam_instance_profile" {
  type = map(string)
  default = {
    dev     = "arn:aws:iam::861112368680:instance-profile/eks-worker-node"
    pprod   = "arn:aws:iam::861112368680:instance-profile/eks-worker-node"
    prod    = "arn:aws:iam::861112368680:instance-profile/eks-worker-node"
  }
}

variable "iam_worker_role" {
  type = map(string)
  default = {
    dev     = "arn:aws:iam::861112368680:role/worker-nodes-role"
    pprod   = "arn:aws:iam::861112368680:role/worker-nodes-role"
    prod    = "arn:aws:iam::861112368680:role/worker-nodes-role"
  }
}
