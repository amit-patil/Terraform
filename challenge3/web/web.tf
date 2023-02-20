resource "aws_instance" "web" {
    ami="ami-0c0d3776ef525d5dd"
    instance_type = "t2.micro"
    security_groups=[module.sg.sg_name]
    user_data = file("./web/server-script.sh")

    tags={
        Name="WebServer"
    }
}

output "pub_ip" {
  value = module.eip.PublicIP
}
output "instance_id" {
  value = aws_instance.web.id
}

module "sg" {
  source = "../sg"
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}


