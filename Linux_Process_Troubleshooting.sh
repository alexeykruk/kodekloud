#!/bin/bash

# The production support team of xFusionCorp Industries has deployed some of the latest 
# monitoring tools to keep an eye on every service, application, etc. running on the systems. 
# One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.

# Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. 
# They might not hosted any code yet on these servers so you need not to worry about if Apache isn't serving any pages or not, 
# just make sure service is up and running. Also, make sure Apache is running on port 6200 on all app servers.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	     	    Nautilus App 1
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	    	    Nautilus App 2
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	     	    Nautilus App 3

# Check all services on the App servers
curl -LI http://172.16.238.10:6200
curl -LI http://172.16.238.11:6200
curl -LI http://172.16.238.12:6200

# httpd service form App1 server doesn't respond

# Connect to App1 server
ssh tony@172.16.238.10

# Check httpd service
sudo sytemctl status httpd
sudo sytemctl enable httpd && sudo sytemctl start httpd

sudo sytemctl status httpd
# Jun 18 08:23:47 stapp01.stratos.xfusioncorp.com httpd[798]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, u...message
# Jun 18 08:23:47 stapp01.stratos.xfusioncorp.com httpd[798]: (98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:6200

# Let's look at network of service that use the same port
sudo netstat -tulpan | grep 6200
# tcp        0      0 127.0.0.1:6200          0.0.0.0:*               LISTEN      522/sendmail: accep

# Find sendmail processes
ps aux | grep sendmail
# root         522  0.0  0.0  88812  3468 ?        Ss   08:21   0:00 sendmail: accepting connections
# smmsp        529  0.0  0.0  84252  3324 ?        Ss   08:21   0:00 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
# tony         866  0.0  0.0  12504  1716 pts/0    S+   08:26   0:00 grep --color=auto sendmail

# Let's squash these processes
sudo kill -9 522 529

# Start httpd proccess and check
sudo sytemctl start httpd && sudo sytemctl status httpd

# Check the response from the service
curl -LI http://172.16.238.10:6200

# Done
