provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "db" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"
    count = 3
}