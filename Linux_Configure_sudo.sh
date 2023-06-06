#!/bin/bash

# We have some users on all app servers in Stratos Datacenter. Some of them have been assigned 
# some new roles and responsibilities, therefore their users need to be upgraded with sudo access so that they can perform admin level tasks.

# a. Provide sudo access to user 'anita' on all app servers.

# b. Make sure you have set up password-less sudo for the user.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	         	Nautilus App 1
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	         	Nautilus App 3

# Connect to server

# Check user anita
id anita

# Show existed groups. (tony & wheel existed)
groups

# Use a visudo and replace these lines

%wheel ALL=(ALL)       ALL
#%wheel  ALL=(ALL)       NOPASSWD: ALL
# to
#%wheel ALL=(ALL)       ALL
%wheel  ALL=(ALL)       NOPASSWD: ALL

# Lets add the user anita to required group

sudo usermod -aG wheel anita

# Done
