provider "aws" {
  region = "us-east-1"
}

#========================================================================================

    ami = data.aws_ami.latest_amazon.id
    instance_type = "t2.micro"
    
   
