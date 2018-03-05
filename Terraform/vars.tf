variable "AWS_REGION" {
  default = "us-west-2"
}

variable "aws_profile" {
	#default = "terraform-kmcgarry"
	default = "eureka-terraform"
}

# AWS Linux AMI ids by Region - https://aws.amazon.com/amazon-linux-ami/
variable "AMIS" {
	 type = "map"
	 default = {
	  us-west-1 = "us-west-1"
	  us-west-2 = "ami-f2d3638a"
	  us-east-1 = "us-east-1"
	  us-east-2 = "ami-f63b1193"
     }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/Users/kevinmcgarry/.ssh/eureka-tf-test"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "/Users/kevinmcgarry/.ssh/eureka-tf-test.pub"
}