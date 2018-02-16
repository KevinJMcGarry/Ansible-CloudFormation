resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  tags {
  	Name = "test_server"
  	role = "Docker-Worker"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ports.id}"]  # notice this is a list, can assign multiple SGs to this instance

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}
