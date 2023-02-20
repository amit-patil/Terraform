resource "aws_instance" "db" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"

    tags={
        Name="DBServer"
    }
}

output "PrivateIP" {
  value=aws_instance.db.private_ip
}