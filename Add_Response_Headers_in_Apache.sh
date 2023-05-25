#!/bin/bash
# We are working on hardening Apache web server on all app servers. As a part of this 
# process we want to add some of the Apache response headers for security purpose. We are testing the 
# settings one by one on all app servers. As per details mentioned below enable these headers for Apache:

#     Install httpd package on App Server 1 using yum and configure it to run on 8089 port, make sure to start its service.
#     Create an index.html file under Apache's default document root i.e /var/www/html and add below given content in it.
#     Welcome to the xFusionCorp Industries!
#     Configure Apache to enable below mentioned headers:
#     X-XSS-Protection header with value 1; mode=block
#     X-Frame-Options header with value SAMEORIGIN
#     X-Content-Type-Options header with value nosniff

# Note: You can test using curl on the given app server as LBR URL will not work for this task.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	        	Nautilus App 1


# Install epel repository and install apache
ssh -t tony@172.16.238.10 'sudo yum install -y epel-release && sudo yum update -y && sudo yum install -y httpd'

# Create an index.html
echo '<h1>Welcome to the xFusionCorp Industries!</h1>' > /var/www/html/index.html

# Change in /etc/httpd/conf/httpd.conf Listen 8080 to Listen 8089
Listen 8089

# Change default document root in /etc/httpd/conf/httpd.conf
DocumentRoot "/var/www/html"

# Add a block of code to the end of file /etc/httpd/conf/httpd.conf
<IfModule mod_headers.c>
  <Directory />
    Header always set X-XSS-Protection "1; mode=block"
    Header always set x-Frame-Options "SAMEORIGIN"
    Header always set X-Content-Type-Options "nosniff"
  </Directory>
</IfModule>

# Enable and restart service
sudo systemctl enable httpd && sudo systemctl start httpd

# Test
curl http://172.16.238.10
