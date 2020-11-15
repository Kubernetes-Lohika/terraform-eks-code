# File generated by aws2tf see https://github.com/awsandy/aws2tf
# aws_route_table.rtb-07745c715a366341d:
resource "aws_route_table" "rtb2-igw" {
  count            = var.mycount
  propagating_vgws = []
  route = [
    {
      cidr_block                = "0.0.0.0/0"
      gateway_id                = aws_internet_gateway.myigw[count.index].id
    },
  ]
  tags   = {}
  vpc_id = aws_vpc.VPC[count.index].id
}
