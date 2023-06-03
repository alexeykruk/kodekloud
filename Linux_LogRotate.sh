#!/bin/bash
# The Nautilus DevOps team is ready to launch a new application, which they will deploy on app servers in Stratos Datacenter. 
# They are expecting significant traffic/usage of tomcat on app servers after that. 
# This will generate massive logs, creating huge log files. To utilise the storage efficiently, 
# they need to compress the log files and need to rotate old logs. Check the requirements shared below:

# a. In all app servers install tomcat package.

# b. Using logrotate configure tomcat logs rotation to monthly and keep only 3 rotated logs.

# (If by default log rotation is set, then please update configuration as needed)

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	         	Nautilus App 1
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	         	Nautilus App 3

# Connect to server
ssh tony@172.16.238.10

# Install the required package
sudo yum install -y tomcat

# Input the required lines into /etc/logrotate.d/tomcat
sudo vi /etc/logrotate.d/tomcat

# lines
monthly
rotate 3

# Apply the tomcat config
sudo logrotate /etc/logrotate.d/tomcat

# Do the same thing on other servers
