variable "iam_role_names" {
  type    = map(string)
  default = {
    cluster_role = "eks-cluster-role"
    node_role    = "eks-node-role"
  }
}
