output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_role_arn" {
  description = "IAM role ARN used by the EKS control plane"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  value       = aws_iam_role.eks_nodes.arn
}

output "vpc_id" {
  description = "VPC ID used by the EKS cluster"
  value       = aws_vpc.eks.id
}

output "subnet_ids" {
  description = "Subnet IDs used by the EKS cluster"
  value       = aws_subnet.eks[*].id
}