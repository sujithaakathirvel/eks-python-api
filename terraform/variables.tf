variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-python-api"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.36"
}

variable "node_instance_type" {
  description = "EC2 instance type for the EKS node group"
  type        = string
  default     = "t3.small"
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}
