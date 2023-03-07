resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Prod-Tlc-VPC"
  }
}

resource "aws_subnet" "Test-public-sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Test-public-sub1"
  }
}

resource "aws_subnet" "Test-public-sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Test-public-sub2"
  }
}

resource "aws_subnet" "Test-priv-sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Test-priv-sub1"
  }
}

resource "aws_subnet" "Test-priv-sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Test-priv-sub2"
  }
}

resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${aws_internet_gateway.Test-pub-route-table.id}"
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = "${aws_egress_only_internet_gateway.Test-pub-route-table.id}"
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "Test-priv-sub1" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.bar.id
}
resource "aws_route_table_association" "Test-priv-sub2" {
  gateway_id     = aws_internet_gateway.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-sub2.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Test-igw"
  }
}