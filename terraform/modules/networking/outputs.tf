#any outputs from networking module

output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.main.id
}

output "subnet_ids" {
    description = "IDs of the created subnets"
    value = aws_subnet.public[*].id 
}

output "security_group_id" {
    description = "ID of the security group created"
    value = aws_security_group.EC2_security_group.id  
}