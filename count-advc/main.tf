provider "aws" {
  region = "eu-central-1"
}

module "db" {
  source = "./db"
  server_names = ["mysql","mariadb","mssql"]
}

output "private_ips" {
  value = module.db.PrivateIP
}