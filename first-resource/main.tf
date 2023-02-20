provider "aws" {
    region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name=var.inputname
    }
}

variable "inputname" {
    type = string
    description = "Enter VPC Name"
}
output "vpcid" {
  value = aws_vpc.myvpc.id
}