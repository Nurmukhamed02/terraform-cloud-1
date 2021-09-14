provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
      bucket = "mybucketnur2"
      key    = "dev/terraform.tfstate"
      region = "us-east-1"
  }
}

data "aws_ami" "latest_amazon" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


variable "ec2_count" {
  default = 1
}

resource "aws_instance" "amazon_instance" {
    count = var.ec2_count
    ami = data.aws_ami.latest_amazon.id
    instance_type = "t2.micro"
    
   
    tags = {
      Name = "My EC2 instance"
   
   }
}
