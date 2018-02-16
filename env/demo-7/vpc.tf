# Internet VPC
resource "aws_vpc" "Eureka_Test_VPC" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"  # gives you an internal domain name
    enable_dns_hostnames = "true"  # give you an internal hostname
    enable_classiclink = "false"  # link your vpc to ec2-classic
    tags {
        Name = "Eureka_Test_VPC"
    }
}


# to find available AZs
# aws ec2 describe-availability-zones --region us-east-2

# Public & Private Subnets
resource "aws_subnet" "main-public-1" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2a"

    tags {
        Name = "main-public-1"
    }
}
resource "aws_subnet" "main-public-2" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2b"

    tags {
        Name = "main-public-2"
    }
}
resource "aws_subnet" "main-public-3" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2c"

    tags {
        Name = "main-public-3"
    }
}
resource "aws_subnet" "main-private-1" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2a"

    tags {
        Name = "main-private-1"
    }
}
resource "aws_subnet" "main-private-2" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"

    tags {
        Name = "main-private-2"
    }
}
resource "aws_subnet" "main-private-3" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2c"

    tags {
        Name = "main-private-3"
    }
}

# Internet GW for public subnets
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.Eureka_Test_VPC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "main-public-1"
    }
}

# route associations for public subnets
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = "${aws_subnet.main-public-1.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-2-a" {
    subnet_id = "${aws_subnet.main-public-2.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-3-a" {
    subnet_id = "${aws_subnet.main-public-3.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
