#!/bin/bash

# a. On App Server 3 at location /var/www/html/news find out all files (not directories) having .js extension.
# b. Copy all those files along with their parent directory structure to location /news on same server.
# c. Please make sure not to copy the entire /var/www/html/news directory content.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	         	Nautilus App 3

ssh -t banner@172.16.238.12 'find /var/www/html/news -type f -name *.js -exec sudo cp --parents {} /news \;'
