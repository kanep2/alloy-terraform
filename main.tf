terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-0da424eb883458071"
  instance_type = "t2.micro"
}     
