resource "aws_security_group" "allow-ports" {
  vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
  name = "allow-ports"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.10.0.10/32", "71.42.237.146/32"]
  } 

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "allow-ports"
  }
}
