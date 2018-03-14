output "dynamic public ip of Ansible Control EC2 Instance" {
  value = "${aws_instance.ansible-control.public_ip}"
}

output "Ansible-Control Public IP (listening on Port 2222)" {
  value = "${aws_instance.ansible-control.public_ip}"
}

output "webservers-subnet-id" {
value = "${aws_subnet.web-private-1.id}"
}

output "elb-dns" {
value = "${aws_elb.webservers-elb.dns_name}"
}

output "availabilityzones" {
value = ["${data.aws_availability_zones.allzones.names}"]
}