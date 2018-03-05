# Internet VPC
resource "aws_vpc" "Eureka_Terraform_Test_VPC" {
    cidr_block = "10.250.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"  # gives you an internal domain name
    enable_dns_hostnames = "true"  # give you an internal hostname
    enable_classiclink = "false"  # link your vpc to ec2-classic
    tags {
        Name = "Eureka_Terraform_Test_VPC"
    }
}


# AWS CLI command to run to find available AZs
# aws ec2 describe-availability-zones --region us-east-2

# data "aws_availability_zones" "allzones" {}

# Public & Private Subnets
resource "aws_subnet" "main-public-1" {
    vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
    cidr_block = "10.250.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2a"

    tags {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "web-private-1" {
    vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
    cidr_block = "10.250.100.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2a"

    tags {
        Name = "main-private-1"
    }
}
resource "aws_subnet" "db-private-1" {
    vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
    cidr_block = "10.250.200.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2a"

    tags {
        Name = "main-private-2"
    }
}

# Internet GW for public subnet
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.Eureka_Terraform_Test_VPC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "IGW for main-public-1 subnet"
    }
}

# route associations for public subnets
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = "${aws_subnet.main-public-1.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
