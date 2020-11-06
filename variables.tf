variable "my_ip" {
  default = "<Your IP>"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80, 443]
}

#West server search for ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#East server search for ami
data "aws_ami" "ubuntu_east" {
  most_recent = true
  provider    = aws.eastside

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
