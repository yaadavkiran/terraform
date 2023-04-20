variable "project" {
     default = "first-project-269313"
}

variable "region" {
    default =  "asia-south1"
}

variable "zone" {
    default = "asia-south1-c"  
}

variable "prefix" {
    default = "nginx"
}

variable "gce_ssh_pub_key_file" {
  default = "C:/Users/karigiki.CORPDOM/.ssh/ssh_pub_key.pub"
}

variable "gce_ssh_user" {
  default = "kiran"
}

variable "vm_name" {
    type = "list"
  default = ["instance1","instance2"]
}
