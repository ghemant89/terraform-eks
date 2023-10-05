data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

data "tls_certificate" "cluster" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "cluster_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

data "aws_iam_policy_document" "eks_node_group_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}