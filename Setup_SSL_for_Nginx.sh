#!/bin/bash

# The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 3 in Stratos Datacenter. 
# They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:
# Install and configure nginx on App Server 3.
# On App Server 3 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.
# Create an index.html file with content Welcome! under Nginx document root.
# For final testing try to access the App Server 3 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	 	        Nautilus App 3

# Install epel repository and install nginx package
ssh -t banner@172.16.238.12 'sudo yum install -y epel-release && sudo yum update -y && sudo yum install -y nginx'

# Connect to server and do an ather steps inside him
ssh banner@172.16.238.12
sudo mkdir -p /var/www && sudo chmod -R a+w /var/www 
echo '<h1>Welcome!</h1>' > /var/www/index.html

sudo cp /tmp/nautilus.crt /etc/ssl/certs/nautilus.crt
sudo cp /tmp/nautilus.key /etc/ssl/certs/nautilus.key

# Add part of code into /etc/nginx/nginx.conf
    server {
        listen       443 ssl;
        server_name  stapp03.stratos.xfusioncorp.com;

        ssl_certificate      /etc/ssl/certs/nautilus.crt;
        ssl_certificate_key  /etc/ssl/certs/nautilus.key;

        ssl_session_cache    shared:SSL:1m;
        ssl_session_timeout  5m;

        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers  on;

        location / {
            root   /var/www;
            index  index.html;
        }
    }

}

sudo systemctl enable nginx
sudo systemctl restart nginx

# Check it from jump_host
ssh -t banner@172.16.238.12 'curl -Ik https://172.16.238.12/'
