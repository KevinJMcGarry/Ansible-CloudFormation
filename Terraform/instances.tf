resource "aws_instance" "ansible-control" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.ansible-control-sg.id}"]
  key_name = "${aws_key_pair.mykeypair.key_name}"
  subnet_id = "${aws_subnet.main-public-1.id}"
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo chkconfig docker on
              sudo yum install git -y
              EOF
  tags {
    Name = "TF-Ansible-Control"
    Environment = "dev"
  }

  root_block_device {
    volume_size = 15
    volume_type = "gp2"
    delete_on_termination = true
  }
}

resource "aws_instance" "web01" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web-servers-sg.id}"]
  key_name = "${aws_key_pair.mykeypair.key_name}"
  subnet_id = "${aws_subnet.web-private-1.id}"
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo chkconfig docker on
              sudo docker run -d -p 80:80 nginx
              sudo useradd ansible -s /bin/bash
              sudo mkdir -p /home/ansible/.ssh/
              sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
              sudo cp /home/ec2-user/.ssh/authorized_keys /home/ansible/.ssh/authorized_keys
              sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
              EOF
  depends_on = ["aws_route_table_association.db-private-1-a"] # nat needs to be running and connected
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
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo chkconfig docker on
              sudo docker run -d -p 80:80 nginx
              EOF
  depends_on = ["aws_route_table_association.db-private-1-a"]
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
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo chkconfig docker on
              EOF
  depends_on = ["aws_route_table_association.db-private-1-a"]
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