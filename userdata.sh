#!/bin/bash -xe
cd /tmp
yum update -y
yum install -y httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>Hello World from: $myip</h2>"  >  /var/www/html/index.html
sudo service httpd start
