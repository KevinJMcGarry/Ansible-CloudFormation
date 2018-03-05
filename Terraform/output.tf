output "webservers-subnet-id" {
value = "${aws_subnet.web-private-1.id}"
}

output "elb-dns" {
value = "${aws_elb.webservers-elb.dns_name}"
}

output "availabilityzones" {
value = ["${data.aws_availability_zones.allzones.names}"]
}