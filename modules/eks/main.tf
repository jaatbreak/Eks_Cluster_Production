# EKS Cluster
resource "aws_eks_cluster" "demo" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = var.security_group_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  tags = {
    Name        = var.cluster_name
    Environment = "Production"
  }
}

# Launch Template for EKS Node Group
resource "aws_launch_template" "node_launch_template" {
  name_prefix   = "eks-node-template"
  image_id      = var.ami_id   # Specify your AMI ID here, or you can use the EKS optimized AMI
  instance_type = var.instance_types

  lifecycle {
    create_before_destroy = true
  }

  # Optional: Add block devices or other configurations for the node instances
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp2"
    }
  }

  tags = {
    Name = "eks-node-template"
  }
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    =  var.cluster_name
  depends_on = [aws_eks_cluster.demo]
  node_group_name = var.node_group_name
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnets
  capacity_type   = "ON_DEMAND"
  node_group_name_prefix = null #"Creates a unique name beginning with the specified prefix. Conflicts with node_group_name"
  scaling_config {
    desired_size  = 1
    max_size      = 2
    min_size      = 1
  }
  update_config {
    max_unavailable = 1
  }
 
  tags = {
    Name = "${var.cluster_name}-nodegroup"
  }
}

