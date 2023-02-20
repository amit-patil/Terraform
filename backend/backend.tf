terraform {
  backend "s3" {
    key="terraform/tfstate.tfstate"
    bucket = "my-amit-test-bucket"
    region = "eu-central-1"
    access_key = ""
    secret_key = ""
  }
}