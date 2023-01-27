terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}
resource "aws_instance" "web" {
  ami           = ami-0597375488017747e
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}