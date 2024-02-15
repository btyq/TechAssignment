#networking module main workflow

#obtaining cidr_info from supposedly an api call form python script
data "external" "cidr_info" {
  program = ["python", "${path.root}/../scripts/cidr_info.py"]
}

#create vpc
resource "aws_vpc" "main" {
  cidr_block = "${data.external.cidr_info.result.ip_address}${data.external.cidr_info.result.subnet_size}"
}

#create subnets
resource "aws_subnet" "public" {
  count            = var.subnet_count
  vpc_id           = aws_vpc.main.id
  cidr_block       = cidrsubnet("${data.external.cidr_info.result.ip_address}${data.external.cidr_info.result.subnet_size}", 8, count.index)
  availability_zone = var.availability_zone
}

#networking setup
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main.id
}

#route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "subnet_association" {
  count = var.subnet_count
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.my_route_table.id
}

#security group
resource "aws_security_group" "EC2_security_group" {
    name = "EC2_security_group"
    description = "EC2 Security Group"
    vpc_id = aws_vpc.main.id

    #(http port 80)
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    #(https port 443)
    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    #(ssh port 22)
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    } 
}



