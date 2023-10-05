resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.name
  }
}

resource "aws_eip" "this" {
  count = length(var.nat_pip) == 0 ? local.nats_count : 0

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  count = local.nats_count

  allocation_id = local.nat_publicIP[count.index]
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  depends_on = [aws_subnet.public]
}

resource "aws_subnet" "public" {
  count                   = length(var.public_cidr)
  availability_zone       = element(var.valid_zones, count.index)
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  count  = length(var.public_cidr)
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "public" {
  count = length(var.public_cidr)

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_cidr)

  route_table_id = aws_route_table.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_subnet" "private" {
  count = length(var.private_cidr)

  vpc_id                  = aws_vpc.this.id
  availability_zone       = element(var.valid_zones, count.index)
  cidr_block              = var.private_cidr[count.index]
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private" {
  count  = length(var.private_cidr)
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "private" {
  count = length(var.private_cidr)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_cidr)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}