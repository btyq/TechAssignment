#generate ssh key
resource "tls_private_key" "ssh_key" {
  algorithm = var.encryption-type
  rsa_bits  = var.encryption-bits
}

#store public key of ssh in folder
resource "local_file" "ssh_public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}

#create aws key pair from public key
resource "aws_key_pair" "Technical_Assignment_keypair" {
  key_name = "Technical-Assignment-keypair"
  public_key = local_file.ssh_public_key.content
}

#create ec2 instances
resource "aws_instance" "Technical_Assignment" {
  count           = var.instance_count
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[count.index % length(var.subnet_ids)]
  associate_public_ip_address = true
  key_name = aws_key_pair.Technical_Assignment_keypair.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${path.module}/nginx/nginx_installation.sh")
}

data "template_file" "nginx_config" {
  template = templatefile("${path.module}/nginx/nginx_config_template.conf", {server = "server", instance_ips = aws_instance.Technical_Assignment[*].private_ip})
}

resource "local_file" "generate_nginx_config" {
  content = data.template_file.nginx_config.rendered
  filename = "${path.module}/nginx/nginx_config.conf"
}

resource "null_resource" "configure_load_balancer" {
  count = 1

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.ssh_key.private_key_pem
    host        = aws_instance.Technical_Assignment[0].public_ip
  }

  provisioner "file" {
    source      = "${path.module}/nginx/nginx_config.conf" 
    destination = "/tmp/nginx_config.conf"  
  }

  provisioner "remote-exec" {
    inline = [
      "until [ -d '/etc/nginx/conf.d/' ]; do sleep 1; done",  
      "sudo cp /tmp/nginx_config.conf /etc/nginx/conf.d/",  
      "sudo nginx -s reload", 
    ]
  }

  depends_on = [local_file.generate_nginx_config]
}







