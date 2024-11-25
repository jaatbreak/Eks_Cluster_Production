output "private_subnets" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
}

output "public_subnet" {
  description = "Public subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.production_vpc.id
}
