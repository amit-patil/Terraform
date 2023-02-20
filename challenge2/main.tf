provider "aws" {
  region = "eu-central-1"
}

variable "ingressrules" {
  type = list(number)
  default = [80,443]
}

variable "egressrules" {
  type = list(number)
  default = [80,443,3306,53]
}

resource "aws_instance" "dbserver" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"

    tags={
        Name="DBServer"
    }
}

resource "aws_instance" "webserver" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"
    security_groups=[aws_security_group.mysecuritygroup.name]
    user_data = file("server-script.sh")

    tags={
        Name="WebServer"
    }
}

resource "aws_eip" "fixedpublicip" {
  instance = aws_instance.webserver.id
  vpc=true
}

resource "aws_security_group" "mysecuritygroup" {
  name="webserversecuritygroup"
  description = "Allow HTTP and HTTPS Traffic"
  
  dynamic ingress {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic egress {
    iterator = port
    for_each = var.egressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name="webserversecuritygroup"
  }
}