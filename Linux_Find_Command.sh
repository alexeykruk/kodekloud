#!/bin/bash

# During a routine security audit, the team identified an issue on the Nautilus App Server. 
# Some malicious content was identified within the website code. After digging into the issue 
# they found that there might be more infected files. Before doing a cleanup they would like to 
# find all similar files and copy them to a safe location for further investigation. 
# Accomplish the task as per the following requirements:

# a. On App Server 2 at location /var/www/html/news find out all files (not directories) having .php extension.
# b. Copy all those files along with their parent directory structure to location /news on same server.
# c. Please make sure not to copy the entire /var/www/html/news directory content.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2

# find out all *.php files and copy with their parent directory structure
ssh -t steve@172.16.238.11 'find /var/www/html/news -type f -name *.php -exec sudo cp --parents {} /news \;'
