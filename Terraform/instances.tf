resource "aws_instance" "web01" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web-servers-sg.id}"]
  key_name = "${aws_key_pair.mykeypair.key_name}"
  subnet_id = "${aws_subnet.web-private-1.id}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              EOF
  tags {
  	Name = "TF-Web01"
  	Environment = "dev"
  }

  root_block_device {
    volume_size = 15
    volume_type = "gp2"
    delete_on_termination = true
  }
}

resource "aws_instance" "web02" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web-servers-sg.id}"]
  key_name = "${aws_key_pair.mykeypair.key_name}"
  subnet_id = "${aws_subnet.web-private-1.id}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              EOF
  tags {
    Name = "TF-Web02"
    Environment = "dev"
  }

  root_block_device {
    volume_size = 15
    volume_type = "gp2"
    delete_on_termination = true
  }
}

resource "aws_instance" "DB01" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.database-servers-sg.id}"]
  key_name = "${aws_key_pair.mykeypair.key_name}"
  subnet_id = "${aws_subnet.db-private-1.id}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              EOF
  tags {
    Name = "TF-DB01"
    Environment = "dev"
  }

  root_block_device {
    volume_size = 25
    volume_type = "gp2"
    delete_on_termination = true
  }
}