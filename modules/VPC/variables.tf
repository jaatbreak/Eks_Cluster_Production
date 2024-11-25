
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "192.168.1.0/26"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A"
  type        = string
  default     = "192.168.1.64/26"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet B"
  type        = string
  default     = "192.168.1.128/26"
}

variable "availability_zone_a" {
  description = "The availability zone for the subnets"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_b" {
  description = "The availability zone for the subnets"
  type        = string
  default     = "us-east-1b"
}