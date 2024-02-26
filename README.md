This is a basic configuration for deploying an EKS cluster with Bottlerocket AMIs. It utilizes managed node groups for simplified management.

1. Prerequisites:

An AWS account with proper IAM permissions.
Kubectl installed and configured to interact with AWS account.

2. Create a Cluster mentioned above ☝️ .

3. Create a Bottlerocket Node Group ☝️.

4. Verify and Access Cluster. 

After the cluster and node group are created, one can verify their status with:

aws eks describe-cluster --name my-eks-cluster
aws eks describe-nodegroup --cluster-name my-eks-cluster --nodegroup-name bottlerocket-ng

To access the cluster, retrieve the kubeconfig file and configure kubectl:

aws eks update-kubeconfig --name my-eks-cluster

5. Additional Considerations:

This is a basic configuration and might require additional steps depending on specific needs.
Bottlerocket AMIs lack a default SSH server. Refer to the official documentation for enabling SSH access if needed https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami-bottlerocket.html.
Explore EKS managed node group scaling policies for automated scaling based on the requirements.

Refer to the official AWS documentation for EKS and Bottlerocket AMIs for detailed instructions and advanced configurations.

