variable "vpc_id" {
    description = "ID of the VPC where EC2 instances will be launched"
    type        = string
}

variable "subnet_ids" {
    description = "List of subnet IDs where EC2 instances will be launched"
    type        = list(string)
}

variable "security_group_id" {
    description = "Security group IDs for EC2 instances"
    type        = string
}

variable "encryption-type" {
    description = "Encryption type of SSH key pair generation"
    type        = string
    default     = "RSA"
}

variable "encryption-bits" {
    description = "Encryption bits"
    type        = number
    default     = 2048
}

variable "instance_count" {
    description = "Number of EC2 instances to launch"
    type        = number
    default     = 5 
}

variable "ami_id" {
    description = "AMI ID for the EC2 instances"
    type        = string
    default     = "ami-0e731c8a588258d0d"
}

variable "instance_type" {
    description = "Instance type for the EC2 instances"
    type        = string
    default     = "t2.micro" 
}