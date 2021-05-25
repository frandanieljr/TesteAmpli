resource "aws_instance" "nginx" {
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.nano"
  subnet_id     = "subnet-c710aaac"
  vpc_security_group_ids = [aws_security_group.HTTP.id]
  user_data	= data.template_file.user_data.rendered
  key_name	= "ampli"
  availability_zone = "us-east-2a" 
  
}


resource "aws_security_group" "HTTP" {
  name        = "HTTP"
  description = "Allow HTTP inbound"
  vpc_id      = "vpc-4d6cfe26"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.my_public_ip.body)}/32", "172.31.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "HTTP_SG"
  }
}

resource "aws_security_group" "HTTPS" {
  name        = "HTTPS"
  description = "Allow HTTPS inbound"
  vpc_id      = "vpc-4d6cfe26"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.my_public_ip.body)}/32", "172.31.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "HTTPS_SG"
  }
}

resource "aws_security_group" "SSH" {
  name        = "SSH"
  description = "Allow SSH inbound"
  vpc_id      = "vpc-4d6cfe26"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.my_public_ip.body)}/32", "172.31.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSH_SG"
  }
}



data "template_file" "user_data" {
  template = file("${path.module}/userdata.sh")

}


resource "aws_ebs_volume" "nginx-example" {
  availability_zone = "us-east-2a"
  size              = 40

  tags = {
    Name = "nginx-example"
  }
}


resource "aws_volume_attachment" "nginx_logs" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx-example.id
  instance_id = aws_instance.nginx.id
}

