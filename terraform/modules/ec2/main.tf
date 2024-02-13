resource "tls_private_key" "ssh_key" {
  algorithm = var.encryption-type
  rsa_bits  = var.encryption-bits
}

resource "local_file" "ssh_public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}

resource "aws_key_pair" "Technical_Assignment_keypair" {
  key_name = "Technical-Assignment-keypair"
  public_key = local_file.ssh_public_key.content
}

resource "aws_instance" "Technical_Assignment" {
  count           = var.instance_count
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[count.index % length(var.subnet_ids)]
  security_groups = var.security_group_id
  associate_public_ip_address = true
  key_name = aws_key_pair.Technical_Assignment_keypair.key_name
}


