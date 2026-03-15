resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "workshop-march-eks-node-group"

  node_role_arn = aws_iam_role.eks_cluster_ng.arn
  subnet_ids    = data.aws_subnets.private.ids

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_ng_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_cluster_ng_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_cluster_ng_AmazonEC2ContainerRegistryReadOnly,
  ]
}