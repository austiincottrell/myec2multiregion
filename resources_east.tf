resource "aws_instance" "webserver2" {
  ami           = data.aws_ami.ubuntu_east.id
  instance_type = var.instance_type
  provider      = aws.eastside
}

resource "aws_security_group" "allow_ssh2" {
  name        = "terraformSecurityGroup"
  provider    = aws.eastside
  description = "Allow SSH and http inbound traffic"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformDemo"
  }
}

#Attaching Dynamic Security Group to EC2 Web Server
resource "aws_network_interface_sg_attachment" "sg_attachment_east" {
  security_group_id    = aws_security_group.allow_ssh2.id
  network_interface_id = aws_instance.webserver2.primary_network_interface_id
}