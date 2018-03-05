output "dynamic public ip of EC2 Instance" {
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