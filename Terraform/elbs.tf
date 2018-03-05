data "aws_availability_zones" "allzones" {}

resource "aws_elb" "webservers-elb" {
  name               = "terraform-webservers-elb"
  # availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  # depends_on = ["aws_subnet.web-private-1"]
  depends_on = ["aws_instance.web01", "aws_instance.web02"]
  subnets = ["${aws_subnet.main-public-1.id}"] # public subnet/s which will contain ELB instances
  security_groups    = ["${aws_security_group.webservers-elb-sg.id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }

  instances                   = ["${aws_instance.web01.id}", "${aws_instance.web02.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  // Uncomment this section and set correct bucket name to enable access logging
  //  access_logs = [
  //    {
  //      bucket = "my-access-logs-bucket"
  //    },
  //  ]

}
