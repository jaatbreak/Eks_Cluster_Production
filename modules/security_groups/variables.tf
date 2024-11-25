variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "192.168.1.0/24"
}

