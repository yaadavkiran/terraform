{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red27\green31\blue34;\red244\green246\blue249;}
{\*\expandedcolortbl;;\cssrgb\c14118\c16078\c18039;\cssrgb\c96471\c97255\c98039;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl340\partightenfactor0

\f0\fs23\fsmilli11900 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 variable "linux-amis" \{\
    default = \{\
        eu-west-1 = "ami-c39604b0"\
        eu-central-1 = "ami-7df01e12"\
    \}\
 \}\
\
\
 resource "aws_key_pair" "web" \{\
    key_name = "web-key"\
    public_key = "$\{file("ssh/test-key.pub")\}"\
 \}\
\
\
resource "aws_instance" "web1" \{\
\
ami = "$\{lookup(var.linux-amis, var.region)\}"\
\
instance_type = "t2.micro"\
\
key_name  = "$\{aws_key_pair.web.key_name\}"\
\
security_groups = ["$\{aws_security_group.Standard.id\}","$\{aws_security_group.Dmz.id\}"]\
\
subnet_id  = "$\{aws_subnet.DmzAz1.id\}"\
\
associate_public_ip_address = "true"\
\
connection \{\
        user = "ec2-user"\
        private_key = "$\{file("ssh/test-key")\}"\
        host = "$\{aws_instance.web1.public_ip\}"\
    \}\
\
provisioner "file" \{\
        source = "./html/index.html"\
        destination = "/tmp/index.html"\
 \}\
\
provisioner "remote-exec" \{\
    inline = [\
\
              "sudo yum install httpd -y",\
              "sudo cp /tmp/index.html /var/www/html/index.html"    \
              ]\
  \}\
\
provisioner "remote-exec" \{\
    scripts = [\
               "scripts/web.sh"\
              ]\
   \}\
/*\
lifecycle \{\
    create_before_destroy = "true"\
  \}\
*/\
\
tags \{\
    Name = "Web-Test1"\
\}\
\
\}\
\
\
output "web1-public-ip" \{\
    value = "$\{aws_instance.web1.public_ip\}"\
\}\
\
resource "aws_instance" "web2" \{\
\
ami = "$\{lookup(var.linux-amis, var.region)\}"\
\
instance_type = "t2.micro"\
\
key_name  = "$\{aws_key_pair.web.key_name\}"\
\
security_groups = ["$\{aws_security_group.Standard.id\}","$\{aws_security_group.Dmz.id\}"]\
\
subnet_id  = "$\{aws_subnet.DmzAz1.id\}"\
\
associate_public_ip_address = "true"\
\
connection \{\
        user = "ec2-user"\
        private_key = "$\{file("ssh/test-key")\}"\
        host = "$\{aws_instance.web2.public_ip\}"\
    \}\
\
provisioner "file" \{\
        source = "./html/index.html"\
        destination = "/tmp/index.html"\
 \}\
\
provisioner "remote-exec" \{\
    inline = [\
\
              "sudo yum install httpd -y",\
              "sudo cp /tmp/index.html /var/www/html/index.html"    \
              ]\
  \}\
\
provisioner "remote-exec" \{\
    scripts = [\
               "scripts/web.sh"\
              ]\
   \}\
\
lifecycle \{\
    create_before_destroy = "true"\
  \}\
\
tags \{\
    Name = "Web-Test2"\
\}\
\
\}\
\
\
output "web2-public-ip" \{\
    value = "$\{aws_instance.web2.public_ip\}"\
\}\
}