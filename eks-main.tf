resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "aws_ssm_parameter" "eks_ami_id" {
  name            = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/image_id"
  with_decryption = true
}


resource "aws_eks_cluster" "cluster" {
  name     = var.eks_name
  version  = var.eks_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = aws_subnet.private[*].id
    security_group_ids      = var.eks_security_group_ids
    endpoint_private_access = var.eks_endpoint_private_access
    endpoint_public_access  = var.eks_endpoint_public_access
    public_access_cidrs     = var.eks_public_access_cidrs
  }


  kubernetes_network_config {
    service_ipv4_cidr = var.eks_service_ipv4_cidr
  }
}

resource "aws_iam_role" "cluster" {
  name = "${var.eks_name}-cluster-role"

  assume_role_policy = data.aws_iam_policy_document.cluster_role_assume_role_policy.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.cluster.name
  addon_name    = "kube-proxy"
  addon_version = var.eks_addon_version_kube_proxy

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  preserve = true
}

resource "aws_eks_addon" "core_dns" {
  cluster_name  = aws_eks_cluster.cluster.name
  addon_name    = "coredns"
  addon_version = var.eks_addon_version_core_dns
}

resource "aws_launch_template" "cluster" {
  name_prefix = "${var.eks_name}-node-group"

  image_id               = data.aws_ssm_parameter.eks_ami_id.value
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = var.ebs_delete_on_termination
      volume_size           = var.ebs_volume_size
      volume_type           = var.ebs_volume_type
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.node_group_name
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    instance_metadata_tags      = "enabled"
    http_put_response_hop_limit = 2
  }

  user_data = base64encode(templatefile("userdata.tpl", {
    CLUSTER_NAME   = aws_eks_cluster.cluster.name,
    B64_CLUSTER_CA = aws_eks_cluster.cluster.certificate_authority[0].data,
    API_SERVER_URL = aws_eks_cluster.cluster.endpoint,
    DNS_CLUSTER_IP = cidrhost(var.eks_service_ipv4_cidr, 10)
  }))
}

resource "aws_iam_role" "node_group" {
  name = var.node_group_role_name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

data "aws_launch_template" "cluster" {
  name = aws_launch_template.cluster.name

  depends_on = [aws_launch_template.cluster]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name = var.eks_name
  node_group_name        = var.node_group_name
  node_role_arn          = aws_iam_role.node_group.arn

  subnet_ids = aws_subnet.private[*].id

  ami_type       = var.ami_type
  disk_size      = var.ebs_volume_size
  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }


  launch_template {
    id      = data.aws_launch_template.cluster.id
    name    = data.aws_launch_template.cluster.name
    version = "latest_version"
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }
}

resource "aws_security_group" "core_dns" {
  name_prefix = "${var.eks_name}-coredns-sg-"
  description = "EKS CoreDNS security group."

  vpc_id = aws_vpc.this.id

  tags = {
    "Name"                                  = "${var.eks_name}-coredns-sg"
    "kubernetes.io/cluster/${var.eks_name}" = "owned"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "core_dns_tcp" {
  security_group_id = aws_security_group.core_dns.id
  description       = "Allow udp egress."

  from_port   = "53"
  to_port     = "53"
  ip_protocol = "tcp"

  cidr_ipv4 = "0.0.0.0/0"
}