resource "aws_security_group" "public_sg" {
  name        = "production-public-sg"
  description = "Security group for public-facing resources"
  vpc_id      = var.vpc_id

  # Consolidating HTTP (80) and HTTPS (443) into a single ingress block
  ingress {
    description      = "Allow HTTP and HTTPS"
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # This is valid for public access
  }

  # Allow outbound traffic to any destination
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # All protocols
    cidr_blocks      = ["0.0.0.0/0"]  # This allows outbound traffic anywhere
  }

  tags = {
    Name = "production-public-sg"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "production-private-sg"
  description = "Security group for private resources"
  vpc_id      = var.vpc_id

  # Allow internal traffic within the VPC (use the VPC CIDR block or 0.0.0.0/0 for any)
  ingress {
    description      = "Allow internal VPC traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = [var.vpc_cidr_block]  # Replace var.vpc_cidr_block with your VPC CIDR block
  }

  # Allow inbound MySQL (RDS) traffic from public SG
  ingress {
    description      = "Allow MySQL traffic from public SG"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.public_sg.id]  # Correct reference to the public SG
  }

  # Allow outbound traffic to any destination
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]  # This allows outbound traffic anywhere
  }

  tags = {
    Name = "production-private-sg"
  }
}