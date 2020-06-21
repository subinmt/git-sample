data "aws_vpc" "eks_vpc" {
  filter {
    name = "tag:Environment"
    #values = var.env_vpc[var.env]
    values = [lookup(var.env_vpc, var.env, null)]
    #values = var.env_vpc["${var.env}"]
  }
}

data "aws_subnet_ids" "my_subnets" {
  vpc_id = data.aws_vpc.eks_vpc.id
}

data "aws_subnet" "subnet" {
  for_each = data.aws_subnet_ids.my_subnets.ids
  id       = each.value
}

resource "aws_eks_cluster" "demo-cluster" {
  name     = var.cluster_name
  role_arn = var.iam_cluster_role[var.env]
  version = var.cluster_version

  vpc_config {
    security_group_ids = var.security_group_ids[var.env]
    subnet_ids = [for s in data.aws_subnet.subnet : s.id]
  }
}
 

