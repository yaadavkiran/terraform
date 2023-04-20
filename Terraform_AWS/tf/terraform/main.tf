variable "name" {
  
}

variable "keypair" {
  
}

variable "size" {
  
}


variable "volumesize" {
  
}

variable "instancecount" {
  
}


output "name" {
  value = "${var.name}-${var.keypair}"
}


output "instance" {
  value = "${var.instancecount}-${var.size}"
}