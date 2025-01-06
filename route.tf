resource "aws_internet_gateway" "gameday_igw" {
  vpc_id = aws_vpc.gameday_vpc.id

  tags = {
    Name = "gameday_igw"
  }
}

resource "aws_route_table" "gameday_rt_a" {
  vpc_id = aws_vpc.gameday_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gameday_igw.id
  }
  tags = {
    Name = "gameday_rt"
  }
}

resource "aws_route_table" "gameday_rt_b" {
  vpc_id = aws_vpc.gameday_vpc.id
  tags = {
    Name = "gameday_rt"
  }
}

resource "aws_route_table_association" "gameday_sub_assoc_a" {
  subnet_id = aws_subnet.gameday_sub_a.id
  route_table_id = aws_route_table.gameday_rt_a.id
}

resource "aws_route_table_association" "gameday_sub_assoc_b" {
  subnet_id = aws_subnet.gameday_sub_b.id
  route_table_id = aws_route_table.gameday_rt_b.id
}