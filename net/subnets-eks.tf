data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet-p1" {
  assign_ipv6_address_on_creation = false
  availability_zone               = data.aws_availability_zones.available.names[0]
  cidr_block                      = "10.0.1.0/24"
  map_public_ip_on_launch         = true
  tags = {
    "Name"                                        = "Public1"
    "kubernetes.io/cluster/${var.cluster-name}"   = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "workshop" = "subnet-p1"
  }
  vpc_id = aws_vpc.cluster.id

  timeouts {}
}

resource "aws_route_table_association" "subnet-p1" {
  depends_on=[aws_route_table.aws_route_table_public]
  route_table_id = aws_route_table.aws_route_table_public.id
  subnet_id      = aws_subnet.subnet-p1.id
}

output "sub-pub1" {
  value = aws_subnet.subnet-p1.id
}

resource "aws_subnet" "subnet-p2" {
  assign_ipv6_address_on_creation = false
  availability_zone               = data.aws_availability_zones.available.names[1]
  cidr_block                      = "10.0.2.0/24"
  map_public_ip_on_launch         = true
  tags = {
    "Name"                                        = "Public2"
    "kubernetes.io/cluster/${var.cluster-name}"            = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "workshop" = "subnet-p2"
  }
  vpc_id = aws_vpc.cluster.id

  timeouts {}
}

resource "aws_route_table_association" "subnet-p2" {
  depends_on=[aws_route_table.aws_route_table_public]
  route_table_id = aws_route_table.aws_route_table_public.id
  subnet_id      = aws_subnet.subnet-p2.id
}

output "sub-pub2" {
  value = aws_subnet.subnet-p2.id
}

resource "aws_subnet" "subnet-p3" {
  assign_ipv6_address_on_creation = false
  availability_zone               = data.aws_availability_zones.available.names[2]
  cidr_block                      = "10.0.3.0/24"
  map_public_ip_on_launch         = true
  tags = {
    "Name"                                        = "Public3"
    "kubernetes.io/cluster/${var.cluster-name}"            = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "workshop" = "subnet-p3"
  }
  vpc_id = aws_vpc.cluster.id

  timeouts {}
}

resource "aws_route_table_association" "subnet-p3" {
  depends_on=[aws_route_table.aws_route_table_public]
  route_table_id = aws_route_table.aws_route_table_public.id
  subnet_id      = aws_subnet.subnet-p3.id
}

output "sub-pub3" {
  value = aws_subnet.subnet-p3.id
}