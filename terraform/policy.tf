# IAM Policy for Cluster make changes that suits the requirments. 
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