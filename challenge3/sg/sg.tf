variable "ingressrules" {
  type = list(number)
  default = [80,443]
}

variable "egressrules" {
  type = list(number)
  default = [80,443,3306,53]
}

resource "aws_security_group" "sg" {
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

output "sg_name" {
  value = aws_security_group.sg.name
}