#!/bin/bash

# As per new application requirements shared by the Nautilus project development team, 
# serveral new packages need to be installed on all app servers in Stratos Datacenter. Most of them are completed except for telnet.
# Therefore, install the telnet package on all app-servers.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	         	Nautilus App 1
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	        	Nautilus App 3

ssh -t tony@172.16.238.10 'sudo yum install -y telnet'
ssh -t steve@172.16.238.11 'sudo yum install -y telnet'
ssh -t banner@172.16.238.12 'sudo yum install -y telnet'
