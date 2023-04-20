resource "aws_vpc" "main" {
    cidr_block       = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

     tags={
         Name = "main"
            }
        }


 resource "aws_subnet" "subnet1" {
   vpc_id     = "${aws_vpc.main.id}"
   cidr_block = "10.1.1.0/24"
   #availability_zone = "${var.availability_zone1}"


  tags={
    Name = "app-subnet-1"
    }
 }