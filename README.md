# EKS

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.19.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eks_addon.core_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_launch_template.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.core_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_security_group_egress_rule.core_dns_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [null_resource.kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cluster_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_node_group_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_launch_template.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.eks_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [tls_certificate.cluster](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | n/a | `string` | `null` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of worker nodes. | `number` | n/a | yes |
| <a name="input_ebs_delete_on_termination"></a> [ebs\_delete\_on\_termination](#input\_ebs\_delete\_on\_termination) | Whether the volume should be destroyed on instance termination. | `bool` | `true` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | The size of the volume in gigabytes. | `number` | `100` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | The volume type. | `string` | `"gp3"` | no |
| <a name="input_eks_addon_version_core_dns"></a> [eks\_addon\_version\_core\_dns](#input\_eks\_addon\_version\_core\_dns) | Core DNS managed EKS addon version. | `string` | `null` | no |
| <a name="input_eks_addon_version_ebs_csi_driver"></a> [eks\_addon\_version\_ebs\_csi\_driver](#input\_eks\_addon\_version\_ebs\_csi\_driver) | AWS ebs csi driver managed EKS addon version. | `string` | `null` | no |
| <a name="input_eks_addon_version_kube_proxy"></a> [eks\_addon\_version\_kube\_proxy](#input\_eks\_addon\_version\_kube\_proxy) | Kube proxy managed EKS addon version. | `string` | `null` | no |
| <a name="input_eks_endpoint_private_access"></a> [eks\_endpoint\_private\_access](#input\_eks\_endpoint\_private\_access) | Whether the Amazon EKS private API server endpoint is enabled. | `bool` | `true` | no |
| <a name="input_eks_endpoint_public_access"></a> [eks\_endpoint\_public\_access](#input\_eks\_endpoint\_public\_access) | Whether the Amazon EKS public API server endpoint is enabled. | `bool` | `true` | no |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | Name of eks. | `string` | n/a | yes |
| <a name="input_eks_public_access_cidrs"></a> [eks\_public\_access\_cidrs](#input\_eks\_public\_access\_cidrs) | List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_eks_security_group_ids"></a> [eks\_security\_group\_ids](#input\_eks\_security\_group\_ids) | List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. | `list(string)` | `[]` | no |
| <a name="input_eks_service_ipv4_cidr"></a> [eks\_service\_ipv4\_cidr](#input\_eks\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes service IP addresses from. | `string` | `null` | no |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS version. | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance types associated with the EKS Node Group. | `list(string)` | <pre>[<br>  "t2.micro"<br>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of worker nodes. | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of worker nodes. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of VPC | `string` | n/a | yes |
| <a name="input_nat_pip"></a> [nat\_pip](#input\_nat\_pip) | n/a | `list(string)` | `[]` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | NodeGroup Name | `string` | `"my-node-group"` | no |
| <a name="input_node_group_role_name"></a> [node\_group\_role\_name](#input\_node\_group\_role\_name) | Node Group Role Name | `any` | n/a | yes |
| <a name="input_private_cidr"></a> [private\_cidr](#input\_private\_cidr) | n/a | `list(string)` | n/a | yes |
| <a name="input_public_cidr"></a> [public\_cidr](#input\_public\_cidr) | n/a | `list(string)` | n/a | yes |
| <a name="input_valid_zones"></a> [valid\_zones](#input\_valid\_zones) | A list of valid availability zones for the subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for VPC network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_arn"></a> [eks\_arn](#output\_eks\_arn) | EKS cluster ARN. |
| <a name="output_eks_id"></a> [eks\_id](#output\_eks\_id) | EKS cluster name. |
| <a name="output_eks_network_config"></a> [eks\_network\_config](#output\_eks\_network\_config) | EKS cluster network configuration. |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | Nat gateway ids |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | A list of private route table id. |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | Private subnet id |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | A list of public route table ids. |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | Public subnet id |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Vpc ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
