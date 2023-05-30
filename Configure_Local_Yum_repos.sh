#!/bin/bash
# The Nautilus production support team and security team had a meeting last month in which they decided to use 
# local yum repositories for maintaing packages needed for their servers. For now they have decided to configure 
# a local yum repo on Nautilus Backup Server. This is one of the pending items from last month, so please configure a 
# local yum repository on Nautilus Backup Server as per details given below.

# a. We have some packages already present at location /packages/downloaded_rpms/ on Nautilus Backup Server.
# b. Create a yum repo named localyum and make sure to set Repository ID to localyum. Configure it to use package's location /packages/downloaded_rpms/.
# c. Install package httpd from this newly created repo.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stbkp01 	172.16.238.16 	stbkp01.stratos.xfusioncorp.com 	clint 	    	    Nautilus Backup Server

# Connect to server
ssh clint@172.16.238.16

# Show repositories
sudo yum repolist

# Create a new file and add a local repository
sudo vi /etc/yum.repos.d/localyum.repo

[localyum]
name=localyum
baseurl=file:///packages/downloaded_rpms/
enabled=1
gpgcheck=0

# Update the repo and install httpd from it
sudo yum update && sudo yum install httpd
