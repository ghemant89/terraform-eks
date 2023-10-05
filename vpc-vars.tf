variable "vpc_cidr_block" {
  description = "CIDR block for VPC network"
  type        = string
}

variable "name" {
  description = "Name of VPC"
  type        = string
}

variable "valid_zones" {
  description = "A list of valid availability zones for the subnets"
  type        = list(string)
}

variable "private_cidr" {
  type = list(string)
}

variable "public_cidr" {
  type = list(string)
}


variable "nat_pip" {
  type    = list(string)
  default = []
}

