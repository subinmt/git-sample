variable "env_vars" {
}

variable "env_vpc" {
  type = map
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
  type = map
  default = {
    dev     = "dev"
    pprod   = "pre-prod"
    prod    = "prod"
  }
}

variable "cluster_version" {
  type = map
  default = {
    dev     = "dev"
    pprod   = "pre-prod"
    prod    = "prod"
  }
}

#variable "aws_iam_instance_profile" {
#  type = map
#  default = {
#    dev     = "arn:aws:iam::861112368680:instance-profile/Ec2Admin-Bastion"
#    pprod   = "arn:aws:iam::861112368680:instance-profile/Ec2Admin-Bastion"
#    prod    = "arn:aws:iam::861112368680:instance-profile/Ec2Admin-Bastion"
#  }
#}

#variable "iam_worker_role" {
#  type = map
#  default = {
#    dev     = "arn:aws:iam::861112368680:role/worker-nodes-role"
#    pprod   = "arn:aws:iam::861112368680:role/worker-nodes-role"
#    prod    = "arn:aws:iam::861112368680:role/worker-nodes-role"
#  }
#}
