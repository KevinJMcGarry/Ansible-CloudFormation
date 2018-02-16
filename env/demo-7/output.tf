# outputs the instances public ip address
output "instance" {
  value = "${aws_instance.example.public_ip}"
}