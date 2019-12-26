
resource "aws_security_group" "exporter_rules" {
  vpc_id      = data.aws_vpc.default.id
  name        = "exporter-instance-rules"
  description = "security group that opens ssh and necessary ports to monitor PostgreSQL"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    from_port   = 9187
    to_port     = 9187
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }
}

data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"] #Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "tls_private_key" "pg_exporter" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "pg_exporter" {
  key_name   = "pg-exporter"
  public_key = tls_private_key.pg_exporter.public_key_openssh
}

resource "aws_instance" "exporter_instance" {

  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = "t3.nano"
  associate_public_ip_address = true
  subnet_id                   = tolist(data.aws_subnet_ids.default_vpc_subnets.ids)[0]
  vpc_security_group_ids      = [aws_security_group.exporter_rules.id]
  key_name                    = aws_key_pair.pg_exporter.key_name

  tags = {
    Name        = "pg-exporter"
    Description = "exporter ec2 instance for PostgreSQL monitoring"
  }

  volume_tags = {
    Name        = "pg-exporter"
    Description = "exporter ec2 instance volume for PostgreSQL monitoring"
  }
}