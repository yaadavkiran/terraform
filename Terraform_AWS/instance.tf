resource "aws_instance" "web" {
  count = length(var.instance_tag)
  ami   = var.ami

  key_name = aws_key_pair.deploy.key_name
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.My_VPC_Security_Group.id]

  #availability_zone = "ap-south-1a"
  tags = {
    Name = element(var.instance_tag, count.index)
  }

resource "aws_key_pair" "deploy" {
  key_name   = "Terraform-test"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7d+xOLSkNBqffjrMT2gQAxH0A0fCK1b5z136OevamlYVuuaqWZjkiTft/3uLhyosguLj0g6KIklE5fTMVTwHWeqtS8B6Zy3N5o21QcBf/F7TwpWG4tqjfuPuDr7pc/nGcl8roBZ/jFhn2iTGQ+HUzbRpKbweFxcfF0Rlygk89Ijac97eGASq9GNUtuCXoSPBLzKQ+DAQ6SRsnDKSkutNPROmXvHhXQO3mmJNCwNkZqjyYJLaFSSCyLdmHhBdHVI44MRMICUckrAwz7qVdIVgsGNvAeiT9sYDg7ecBi4G6ENuIs3F2twotEIKyp/b+ZnzVr5ZfPXtoeWfvjJYwbIqnahkgFR2Bh1dDl6l399x3k0lj8aMcJ0AWoxfndAelOvbwKheu8sVz3CjG8d/xk6f/LhoCmsKEpBJAEoTGmL/5tWg/wVTrL2XzwbGo/3FB8oArUZgT0nu3XFnOhdYLJmhF0vk7mfWnJ/tldK2x9azC3g0pXhpqSjr01zER6r1k2i0= kiran"
}


