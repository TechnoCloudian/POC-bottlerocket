# Configure AWS Provider
provider "aws" {
  region = "eu-west-1"
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

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "cluster_role_policy" {
  role       = aws_iam_role.cluster_role.id
  policy_arn = aws_iam_policy.cluster_policy.arn
}

# Bottlerocket AMI (replace name /ami with desired region and architecture where it is available, for example; /aws/eks/optimized/ami/x86_64/amazon-eks-optimized-ami-bottlerocket-x86_64-6.0.0-1.el8.el7/latest)
data "aws_ssm_parameter" "bottlerocket_ami" {
  name = "/aws/eks/optimized/ami/x86_64/amazon-eks-optimized-ami-bottlerocket-x86_64-xxxxxxxxxx"
}

# Launch Template for Bottlerocket Nodes
resource "aws_launch_template" "bottlerocket_lt" {
  name = "bottlerocket-lt"
  image_id         = data.aws_ssm_parameter.bottlerocket_ami.value
  instance_type    = "t2.micro" # Replace with desired instance type
  security_group_ids = [aws_security_group.eks_sg.id]
}
