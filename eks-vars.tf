variable "eks_name" {
  type        = string
  description = "Name of eks."
}

variable "eks_version" {
  type        = string
  description = "EKS version."
}

variable "node_group_name" {
  description = "NodeGroup Name"
  default     = "my-node-group"
}

variable "instance_types" {
  type        = list(string)
  description = "List of instance types associated with the EKS Node Group."
  default     = ["t2.micro"]
}

variable "eks_service_ipv4_cidr" {
  type        = string
  description = "The CIDR block to assign Kubernetes service IP addresses from."
  default     = null
}

variable "eks_public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  default     = ["0.0.0.0/0"]
}

variable "eks_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
  default     = []
}

variable "eks_endpoint_private_access" {
  type        = bool
  description = "Whether the Amazon EKS private API server endpoint is enabled."
  default     = true
}

variable "eks_endpoint_public_access" {
  type        = bool
  description = "Whether the Amazon EKS public API server endpoint is enabled."
  default     = true
}

variable "eks_addon_version_kube_proxy" {
  type        = string
  description = "Kube proxy managed EKS addon version."
  default     = null
}

variable "eks_addon_version_core_dns" {
  type        = string
  description = "Core DNS managed EKS addon version."
  default     = null
}

variable "eks_addon_version_ebs_csi_driver" {
  type        = string
  description = "AWS ebs csi driver managed EKS addon version."
  default     = null
}

variable "ebs_delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination."
  default     = true
}

variable "ebs_volume_size" {
  type        = number
  description = "The size of the volume in gigabytes."
  default     = 100
}

variable "ebs_volume_type" {
  type        = string
  description = "The volume type."
  default     = "gp3"
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes."
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes."
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes."
}

variable "ami_type" {
  type    = string
  default = null
}

variable "node_group_role_name" {
  description = "Node Group Role Name"
}