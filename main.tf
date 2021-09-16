provider "aws" {
  region = "us-east-1"
}

#========================================================================================
terraform {
  backend "remote" {
      hostname = "app.terraform.io"
      organization = "ant-engineering"
      
    workspace {
      name = "DEV"
   }
 }
}
#=============================================================================================
data "aws_ami" "latest_amazon" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}




resource "aws_instance" "amazon_instance" {
    count = 2
    ami = data.aws_ami.latest_amazon.id
    instance_type = "t2.micro"
    
   
    tags = {
      Name = "My EC2"
   
   }
}
