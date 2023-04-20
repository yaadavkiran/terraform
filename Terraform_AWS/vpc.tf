resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name     = "main"
    Location = "Bangalore"
  }
}

resource "aws_security_group" "My_VPC_Security_Group" {
  vpc_id       = aws_vpc.main.id
  name         = "My VPC Security Group"
  description  = "My VPC Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
   Name = "My VPC Security Group"
   Description = "My VPC Security Group"
  }
} 

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet1_cidr

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet2_cidr

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet3_cidr

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = aws_vpc.main.id
  tags = {
        Name = "My VPC Internet Gateway"
  }
}

resource "aws_route_table" "My_VPC_route_table" {
 vpc_id = aws_vpc.main.id
 tags = {
        Name = "My VPC Route Table"
  }
}
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} 

resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} 