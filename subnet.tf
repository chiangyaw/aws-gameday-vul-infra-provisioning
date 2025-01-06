resource "aws_subnet" "gameday_sub_a" {
  vpc_id        = aws_vpc.gameday_vpc.id
  cidr_block    = cidrsubnet(aws_vpc.gameday_vpc.cidr_block, 8, 1)
  map_public_ip_on_launch = "true"
  availability_zone = "${var.region}a"
  tags          = {
    Name = "gameday_subnet"
  }
}

resource "aws_subnet" "gameday_sub_b" {
  vpc_id        = aws_vpc.gameday_vpc.id
  cidr_block    = cidrsubnet(aws_vpc.gameday_vpc.cidr_block, 8, 2)
  map_public_ip_on_launch = "true"
  availability_zone = "${var.region}b"
  tags          = {
    Name = "gameday_subnet"
  }
}