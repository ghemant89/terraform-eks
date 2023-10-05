output "vpc" {
  description = "Vpc ID"
  value       = aws_vpc.this
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.this[*].id
  description = "Nat gateway ids"
}

output "public_route_table_ids" {
  description = "A list of public route table ids."
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "A list of private route table id."
  value       = aws_route_table.private[*].id
}


output "private_subnet_id" {
  description = "Private subnet id"
  value       = aws_subnet.private[*].id
}

output "public_subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.public[*].id
}

output "eks_id" {
  value       = aws_eks_cluster.cluster.id
  description = "EKS cluster name."
}

output "eks_arn" {
  value       = aws_eks_cluster.cluster.arn
  description = "EKS cluster ARN."
}

output "eks_network_config" {
  value       = aws_eks_cluster.cluster.kubernetes_network_config
  description = "EKS cluster network configuration."
}
