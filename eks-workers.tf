data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.demo-cluster.version}-v*"]
  }
  most_recent = true
  owners      = ["602401143452"] # Amazon
}
# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.demo-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.demo-cluster.certificate_authority[0].data}' var.cluster-name
USERDATA
}
resource "aws_launch_configuration" "demo" {
  associate_public_ip_address = true
  #iam_instance_profile = aws_iam_instance_profile.node.name
  iam_instance_profile = "arn:aws:iam::861112368680:instance-profile/eks-worker-node"
  image_id = data.aws_ami.eks-worker.id
  instance_type = lookup(var.instance_type, var.env, null)
  key_name = "singapore"
  name_prefix = "terraform-eks-demo"
  #security_groups = [aws_security_group.demo-node-wrkgrp.id]
  #security_groups = var.security_group_ids
  security_groups = lookup(var.sg_wrk_nodes_ids, var.env, null)
  user_data_base64 = base64encode(local.demo-node-userdata)
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "demo" {
  desired_capacity = lookup(var.asg_desired, var.env, null) 
  launch_configuration = aws_launch_configuration.demo.id
  max_size = lookup(var.asg_max, var.env, null)
  min_size = lookup(var.asg_min, var.env, null)
  name = "terraform-eks-demo"
  #vpc_zone_identifier = module.vpc.public_subnets
  vpc_zone_identifier = [for s in data.aws_subnet.subnet : s.id]
  tag {
    key = "Name"
    value = "terraform-eks-demo"
    propagate_at_launch = true
  }
  tag {
    key = "kubernetes.io/cluster/${var.cluster-name}"
    value = "owned"
    propagate_at_launch = true
  }
}
