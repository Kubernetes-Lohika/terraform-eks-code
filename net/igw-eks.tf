resource "aws_internet_gateway" "igw-eks" {
  tags = {
    "Name" = "igw-eks-custer"
  }
  vpc_id = aws_vpc.cluster.id
}