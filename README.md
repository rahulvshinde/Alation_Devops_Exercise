# Implementation of HAProxy load balancer for web application running on AWS EC2 Instances

## Prerequisites:
1. Clone git repo: https://github.com/rahulvshinde/Alation_Devops_Exercise.git and `cd` into the project directory.
2. Create your own SSH key pair and save them as mykey and mykey.pub in the project directory. Key pair will be required to ssh to the EC2 instances.
3. Create AWS IAM user with "Programmatic access", attached "AmazonEC2FullAccess" and "IAMUserSSHKeys" policies. Copy the AWS Access key and AWS Secret Key for the user in terraform.tfvars file.

## Setup
1. `terraform apply` will provision infrastructure on AWS including webservers and the HAProxy load balancer.
2. By default HAProxy load balancer is using "Round Robin" technique. But I have also added configuration for "Sticky Session" in the haproxy.cfg file. However, for testing purpose I've commented that configuration. Feel free to comment/uncomment Sticky session
configuration block.
```
#---------------------------------------------------------------------
# round robin balancing between the various backends without
# Sticky session
#---------------------------------------------------------------------
backend http_back
   balance     roundrobin
   server  web1 172.31.17.227:80 check
   server  web2 172.31.22.76:80 check
```
```
#---------------------------------------------------------------------
# round robin balancing between the various backends with
# Sticky session
#---------------------------------------------------------------------
#backend http_back
#    balance     roundrobin
#    cookie SRVNAME insert
#    server  web1 172.31.17.227:80 cookie WA check
#    server  web2 172.31.22.76:80 cookie WB check
```
3. HAProxy config file dynamically gets updated through terraform code with correct private IPs of both web servers.
4. Successful `terraform apply` will show private and public IP addresses for HAProxy Load Balancer, and both web servers.
```
Outputs:
haproxy_private_ip = 172.31.30.207
haproxy_public_ip = 13.56.138.134
web1_private_ip = 172.31.17.227
web1_public_ip = 13.56.156.152
web2_private_ip = 172.31.22.76
web2_public_ip = 18.144.39.94
```
5. In order to verify if the load balancing happening as expected run following command.
`shell> for i in {1..5}; do curl 13.56.138.134; done`
Expected Output:
```
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.17.227</h2>
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.17.227</h2>
<h2>Hello World from: 172.31.22.76</h2>
```
You will see requests getting distributed equally among both web servers.
6. If we take down one of the web servers, all requests should go to the other web servers.
`shell> for i in {1..5}; do curl 13.56.138.134; done`
Expected Output:
```
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.22.76</h2>
<h2>Hello World from: 172.31.22.76</h2>
```
7. Make sure you destroy infrastructure once done by running `terraform destroy`.
