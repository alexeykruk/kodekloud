#!/bin/bash

# We have one of our websites up and running on our Nautilus infrastructure in Stratos DC. 
# Our security team has raised a concern that right now Apache’s port i.e 6200 is open 
# for all since there is no firewall installed on these hosts. So we have decided to add 
# some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:

#     Install iptables and all its dependencies on each app host.

#     Block incoming port 6200 on all apps for everyone except for LBR host.

#     Make sure the rules remain, even after system reboot.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	Ir0nM@n 	Nautilus App 1
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	Am3ric@ 	Nautilus App 2
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	BigGr33n 	Nautilus App 3
# stlb01 	172.16.238.14 	stlb01.stratos.xfusioncorp.com 	loki 	Mischi3f 	Nautilus HTTP LBR

# ssh connect to every App server and do the same

sudo yum install -y iptables-services
sudo systemctl start iptables && sudo systemctl enable iptables

sudo iptables -nvL

sudo iptables -A INPUT -p tcp -s 172.16.238.14 --destination-port 6200 -j ACCEPT
sudo iptables -A INPUT -p tcp --destination-port 6200 -j DROP

sudo iptables -L --line-numbers
sudo iptables -R INPUT 5 -p icmp -j REJECT

sudo service iptables save
