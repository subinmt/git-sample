data "aws_vpc" "eks_vpc" {
  filter {
    name = "tag:Environment"
    values = ["${var.env_vpc}"]
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
  name     = "$Cluster_Name"
  role_arn = var.iam_cluster_role
  version = "$EKS_Version"

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids = [for s in data.aws_subnet.subnet : s.id]
  }
}
 

