#!/bin/bash

# Some users of the monitoring app have reported issues with xFusionCorp Industries mail server. 
# They have a mail server in Stork DC where they are using postfix mail transfer agent. 
# Postfix service seems to fail. Try to identify the root cause and fix it.

# Infrastructure Details¶
# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stmail01 	172.16.238.17 	stmail01.stratos.xfusioncorp.com 	groot 	         	Nautilus Mail Server

ssh groot@172.16.238.17

sudo su

systemctl status postfix

systemctl enable postfix && systemctl status postfix

journalctl -xe | grep postfix

echo "myhostname = stmail01.stratos.xfusioncorp.com" >> /etc/postfix/main.cf
echo "mydomain = stratos.xfusioncorp.com" >> /etc/postfix/main.cf
echo "mynetworks = 172.16.238.0/24, 127.0.0.0/8" >> /etc/postfix/main.cf

systemctl status postfix

sudo vi /etc/postfix/main.cf
#inet_interface = localhost

systemctl start postfix && systemctl status postfix

# Done
