output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role" {
  value = aws_iam_role.eks_node_role.arn
}