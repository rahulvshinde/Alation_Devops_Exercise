variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-west-1 = "ami-01c1168b9f7398306"
    us-east-1 = "ami-0ee02acd56a52998e"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "centos"
}

