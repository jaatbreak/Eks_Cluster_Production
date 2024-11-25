variable "ami_id" {
  description = "The AMI ID for the EKS node instances"
  type        = string
  default = "ami-005fc0f236362e99f"

}


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "production-cluster"
}

variable "eks_cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for EKS Cluster"
  type        = list(string)
}

variable "service_ipv4_cidr" {
  description = "Service CIDR block for EKS Cluster"
  type        = string
  default     = "10.100.0.0/16"
}

variable "node_group_name" {
  description = "Name of the EKS Node Group"
  type        = string
  default     = "production-private-nodes"
}

variable "eks_node_role_arn" {
  description = "IAM Role ARN for EKS Node Group"
  type        = string
}

variable "instance_types" {
    description = "type of the node using "
    type = string 
    default = "t2.medium" 
}

