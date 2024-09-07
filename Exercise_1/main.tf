# TODO: Designate a cloud provider, region, and credentials

provider "aws" {
  region     = "us-east-1"
 
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "Udacity_T2" {
  ami           = "ami-02c21308fed24a8ab"
  instance_type = "t2.micro"
  count         = 4
}


# TODO: provision 2 m4.large EC2 instances named Udacity M4
