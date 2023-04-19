resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block


  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_security_group" "main-sg" {
  name        = var.security_group_name
  description = var.security_group_desc
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = var.security_group_ingress_Protocol
    cidr_blocks = var.security_group_cidr
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = var.security_group_ingress_Protocol
    cidr_blocks = var.security_group_cidr
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = var.security_group_ingress_Protocol
    cidr_blocks = var.security_group_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.security_group_cidr
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main-rt"
  }
}

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.main-rt.id
}

resource "aws_instance" "web-server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key
  subnet_id                   = aws_subnet.public-subnet.id
  security_groups             = [aws_security_group.main-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "db-server" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.private-subnet.id
  security_groups = [aws_security_group.main-sg.id]

  tags = {
    Name = "db-server"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  subnet_id = aws_subnet.public-subnet.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "nat-gw"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}
