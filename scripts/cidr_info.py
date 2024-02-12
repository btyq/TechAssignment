import json

#assumption of cidr information
#supposedly using an rest api to retrieve information
#can be done so using requests module
#information is hard coded in this case for the technial assignment

cidr_info = { 
    "ip_address" : "192.168.0.0",
    "subnet_size" : "/16"
}

print(json.dumps(cidr_info))
