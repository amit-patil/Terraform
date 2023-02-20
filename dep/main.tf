provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "db" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"

    tags={
        Name="DB"
    }
}

resource "aws_instance" "web" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"

    tags={
        Name="Web"
    }

    depends_on = [
      aws_instance.db
    ]
}