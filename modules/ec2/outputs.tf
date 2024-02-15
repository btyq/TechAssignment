output "private_ips" {
  value = aws_instance.Technical_Assignment[*].private_ip
}