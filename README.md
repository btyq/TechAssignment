# TechAssignment
Design an automation deployed with GITHUB/GITLAB pipelines to create load balanced simple nginx hosted on 1 or more virtual machines on AWS or Azure with the following assumption :

 

  1.CIDR retrieve from REST API https://FDQN/vend_ip return
{

   "ip_address":"192.168.0.0",

   "subnet_size":"/16"

}

  2.Create subnets with size /24

  3.Generate SSH key for VM credential

  4.Take into consideration CSP Best Practices such as security and resiliency

  5.Take into consideration coding/scripting practices

  6.Leverage on native cloud metrics/logging for error handling

  7.Can use bash/terraform/python/powershell for the stack, github or github for the IAC pipeline

=====================================================================================================================================================================================================================================================================

Upon pull request, terraform.yml in /.github/workflows/terraform.yml will execute
Using terraform cloud stores state file / compare state file that is in terraform cloud.
(PULL REQUEST WILL ONLY EXECUTE TILL terraform plan)

Upon merge to main branch, terraform.yml in /.github/workflows/terraform.yml will executte
Using terrform cloud cloud which has the stored state file. This is compare the terraform infrastructure that exist in the cloud
and perform terraform apply. 
ec2-instance-i-0fac90461602ef99f distrubtes network to [ec2-instance-i-0d65f2b5eb6623707,ec2-instance-i-056cdd3558d594f30,ec2-instance-i-0d9303fbdc5a1791f,ec2-instance-i-0d9303fbdc5a1791f]
Images below show load-balacing network traffic distributions between ec2 instances

![cloudwatch](https://github.com/btyq/TechAssignment/assets/115785548/a28a63c7-ff4d-4e18-80f7-81a1a939b1a4)

Images below show that github actions terraform.yml is working 

Pull request
![pullrequest](https://github.com/btyq/TechAssignment/assets/115785548/b0c38f9c-c475-4fd8-a991-17a9f24b7d98)

Merge request
![merge](https://github.com/btyq/TechAssignment/assets/115785548/6d258bfe-f624-4227-b7e1-17f323ff6d70)


