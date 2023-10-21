terraform {
  backend "s3" {
    bucket = "corptfstatekrhxjymgcddkajnp"
    key    = "mtip/tfstate"
    region = "us-east-1" # Replace with your desired region
  }
}

# Create the VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr # Replace with your desired CIDR block

  tags = {
    Name = var.vpc_tag
  }
}

# Create the subnet
resource "aws_subnet" "eks_subnet_1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.subnet_cidr_1 # Replace with your desired CIDR block
  availability_zone       = var.subnet_az_1 # Replace with your desired availability zone

  tags = {
    Name = var.subnet_tag
  }
}

resource "aws_subnet" "eks_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.subnet_cidr_2 # Replace with your desired CIDR block
  availability_zone       = var.subnet_az_2 # Replace with your desired availability zone

  tags = {
    Name = var.subnet_tag
  }
}

# Create the EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_name # Replace with your desired cluster name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version # Replace with your desired EKS version

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id]
    endpoint_public_access = false
    endpoint_private_access =  true
  }

  tags = {
    Name = var.eks_tag
  }
}

# Create the IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary policies to the IAM role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Output the EKS cluster details
output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}