#variables declared for networking module

variable "subnet_count" {
    description = "Number of subnets to create. Originally 256, but AWS free tier only allow 200"
    type = number
    default = 200
}

variable "availability_zone" { 
    description = "Avaibility zone for subnets"
    type = string
    default = "us-east-1a" 
}