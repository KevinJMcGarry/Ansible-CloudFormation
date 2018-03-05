resource "aws_security_group" "ansible-control-sg" {
  vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
  name = "tf-test-ansible-control-sg"
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
      cidr_blocks = ["66.69.227.6/32", "71.42.237.146/32"]
  } 

tags {
    Name = "Ansible Control SG"
  }
}

resource "aws_security_group" "web-servers-sg" {
  vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
  name = "tf-test-web-servers-sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      # cidr_blocks = ["66.69.227.6/32", "71.42.237.146/32"]
      security_groups = ["${aws_security_group.webservers-elb-sg.id}"]  # only allowing traffic from ELB for this ingress port
  } 

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = ["${aws_security_group.webservers-elb-sg.id}"]  # only allowing traffic from ELB for this ingress port
  } 

tags {
    Name = "Web Servers SG"
  }
}

resource "aws_security_group" "database-servers-sg" {
  vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
  name = "tf-test-database-servers-sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 27017
      to_port = 27017
      protocol = "tcp"
      cidr_blocks = ["66.69.227.6/32", "71.42.237.146/32"]
  } 

tags {
    Name = "Database Servers SG"
  }
}

resource "aws_security_group" "webservers-elb-sg" {
  vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
  name = "web-servers-elb-sg"
  description = "security group that allows ssh and all egress traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




