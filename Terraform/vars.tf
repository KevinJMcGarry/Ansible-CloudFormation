variable "AWS_REGION" {
  default = "us-west-2"
}

// change to the aws cli profile you would like to use
variable "aws_profile" {
	#default = "terraform-kmcgarry"
	default = "eureka-terraform"
}

// AWS Linux AMI ids by Region - https://aws.amazon.com/amazon-linux-ami/
variable "AMIS" {
	 type = "map"
	 default = {
	  us-west-1 = "us-west-1"
	  us-west-2 = "ami-f2d3638a"
	  # us-west-2 = "ami-a042f4d8"
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