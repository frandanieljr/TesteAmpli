provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  owners      = ["679593333241"] # CanonicalID
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_caller_identity" "current" {}

data "http" "my_public_ip" {
  url = "https://api.ipify.org/"
}
