provider "aws" {
    region = "us-east-1"
}
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my_vpc"
    }
  
}
resource "aws_subnet" "pub-subnet" {
  vpc_id = aws_vpc.my_vpc.id  
  cidr_block = "10.0.0.0/24"
  tags = {
  Name = "pub-subnet"
  }
}
 
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.my_vpc.id  
  cidr_block = "10.0.1.0/24"
  tags = {
  Name = "private-subnet"
  }
} 

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my_igw"
    } 
}
  
resource "aws_route_table" "my_pub_rt" {
  vpc_id = "aws_vpc.my_vpc.id"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id  
  }

  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "my_rt_association1" {
    subnet_id = aws_subnet.pub-subnet.id
    route_table_id = aws_route_table.my_pub_rt.id  
  
}

resource "aws_route_table_association" "my_rt_association2" {
    gateway_id = aws_internet_gateway.my_igw.id
    route_table_id = aws_internet_gateway.my_igw.id

}

resource "aws_nat_gateway" "my_nat" {
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.pub-subnet.id

    tags = {
      "Name" = "nat_gw"
    }
  
}
resource "aws_eip" "my_eip"{
    vpc = true
}
  
