variable "region"{    

}

variable "vpc_cidr_block" {
  
}
variable "vpc_name" {
  
}
variable "public_subnet_cidr_block" {
  
}
variable "public_subnet_name" {
  
}
variable "private_subnet_cidr_block" {
  
}
variable "private_subnet_name" {
  
}

variable "security_group_name" {
  
}
variable "security_group_desc" {
  
}
variable "security_group_cidr" {
    default = ["0.0.0.0/0"]
  
}
variable "security_group_ingress_Protocol" {
    default = "tcp"
  
}
variable "internet_gateway_name" {
  
}

variable "instance_ami" {
    default = "ami-03a933af70fa97ad2"
  
}
variable "instance_type" {
    default = "t2.micro"
  
}
variable "instance_key" {
    default = "my-kp"
  
}