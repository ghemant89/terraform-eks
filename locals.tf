locals {
  nat_publicIP = length(var.nat_pip) > 0 ? var.nat_pip : aws_eip.this[*].id
  nats_count   = min(length(var.public_cidr), length(var.valid_zones))
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.eks_name}"
  }
  depends_on = [aws_eks_cluster.cluster, aws_eks_node_group.node_group]
}
