provider "aws" { 
    profile = "${var.aws_profile}"
    region = "${var.AWS_REGION}"
}