#!/bin/bash

# Some of the developers from Nautilus project team have asked for SFTP access to at least one 
# of the app server in Stratos DC. After going through the requirements, the system admins team 
# has decided to configure the SFTP server on App Server 3 server in Stratos Datacenter. 
# Please configure it as per the following instructions:

# a. Create an SFTP user ammar and set its password to LQfKeWWxWD.
# b. Password authentication should be enabled for this user.
# c. Set its ChrootDirectory to /var/www/webapp.
# d. SFTP user should only be allowed to make SFTP connections.

# Server Name 	IP 	Hostname 	User 	Password 	Purpose
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	BigGr33n 	Nautilus App 3

ssh banner@172.16.238.12

sudo useradd ammar
sudo passwd ammar

sudo mkdir -p /var/www/webapp
sudo chmod 755 /var/www
sudo chown root:root -R /var/www
sudo chown ammar:ammar /var/www/webapp

sudo vi /etc/ssh/sshd_config

Match User ammar
ChrootDirectory /var/www/webapp
PasswordAuthentication yes
ForceCommand internal-sftp
PermitTunnel no
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no

sudo systemctl restart sshd

ssh ammar@localhost
sftp ammar@localhost
