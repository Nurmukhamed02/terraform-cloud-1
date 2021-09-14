provider "aws" {
  region = "us-east-1"
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
  default = 2
}

resource "aws_instance" "amazon_instance" {
    count = var.ec2_count
    ami = data.aws_ami.latest_amazon.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.amazon_security_group.id]
    subnet_id = module.network.public_subnet_ids[0]
    user_data = file("user_data")

    tags = {
      Name = "My EC2 instance"
      env = "var.env"
   }
}
