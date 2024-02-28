# Configure AWS Provider
provider "aws" {
  region = "your-aws-region"
}

# Create EKS Cluster
resource "aws_eks_cluster" "my_eks_cluster" {
  name          = "my-eks-cluster"
  role_arn       = aws_iam_role.cluster_role.arn
  vpc_config {
    security_group_ids = [aws_security_group.eks_sg.id]
  }
  kubernetes_version = "1.24" # Replace with desired version
}

# IAM Role for Cluster
resource "aws_iam_role" "cluster_role" {
  name = "eks-cluster-role"
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

# IAM Policy for Cluster
resource "aws_iam_policy" "cluster_policy" {
  name = "eks-cluster-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:PassRole",
        "iam:CreateServiceLinkedRole",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateSecurityGroups",
        "ec2:DeleteSecurityGroups",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeSubnets",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:DeleteTargetGroup",
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeLaunchTemplates",
        "autoscaling:CreateAutoScalingGroup"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "cluster_role_policy" {
  role       = aws_iam_role.cluster_role.id
  policy_arn = aws_iam_policy.cluster_policy.arn
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_sg" {
  name = "eks-sg"
  description = "Security group for EKS cluster"

  ingress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bottlerocket AMI (replace with desired region and architecture)
data "aws_ssm_parameter" "bottlerocket_ami" {
  name = "/aws/eks/optimized/ami/x86_64/amazon-eks-optimized-ami-bottlerocket-x86_64-6.0.0-1.el8.el7/latest"
}

# Launch Template for Bottlerocket Nodes
resource "aws_launch_template" "bottlerocket_lt" {
  name = "bottlerocket-lt"
  image_id         = data.aws_ssm_parameter.bottlerocket_ami.value
  instance_type    = "t3.medium" # Replace with desired instance type
  security_group_ids = [aws_security_group.eks_sg.id
}
