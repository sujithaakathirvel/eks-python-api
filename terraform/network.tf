data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "eks" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_subnet" "eks" {
  count = 2

  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.cluster_name}-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "eks" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_route_table" "eks" {
  vpc_id = aws_vpc.eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks.id
  }

  tags = {
    Name = "${var.cluster_name}-route-table"
  }
}

resource "aws_route_table_association" "eks" {
  count = 2

  subnet_id      = aws_subnet.eks[count.index].id
  route_table_id = aws_route_table.eks.id
}
