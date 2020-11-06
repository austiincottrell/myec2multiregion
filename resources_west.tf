resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "TerrafromDemo"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "terraformSecurityGroup"
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

#Attaching Elastic IP to EC2 Web Server
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.webserver.id
  allocation_id = aws_eip.myeip.id
}

#Attaching Dynamic Security Group to EC2 Web Server
resource "aws_network_interface_sg_attachment" "sg_attachment_west" {
  security_group_id    = aws_security_group.allow_ssh.id
  network_interface_id = aws_instance.webserver.primary_network_interface_id
}