#!/bin/bash

# The system admins team of xFusionCorp Industries has set up a new tool on all app servers, 
# as they have a requirement to create a service user account that will be used by that tool.
# They are finished with all apps except for App Server 2 in Stratos Datacenter.
# Create a user named james in App Server 2 without a home directory.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2

ssh -t steve@172.16.238.11 'sudo useradd --no-create-home james'
