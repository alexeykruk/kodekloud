# We have a backup management application UI hosted on Nautilus's backup server in Stratos DC. 
# That backup management application code is deployed under Apache on the backup server itself, 
# and Nginx is running as a reverse proxy on the same server. Apache and Nginx ports are 8088 and 8095, 
# respectively. We have iptables firewall installed on this server. Make the appropriate changes to fulfill the requirements mentioned below:

# We want to open all incoming connections to Nginx's port and block all incoming connections to Apache's port. 
# Also make sure rules are permanent.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stbkp01 	172.16.238.16 	stbkp01.stratos.xfusioncorp.com 	clint 	    	    Nautilus Backup Server

# Connect to Nautilus Backup Server
ssh clint@172.16.238.16

# Flush the current iptables rules
iptables -F 

# Allow incoming traffic on Nginx’s port (8095)
iptables -A INPUT -p tcp --dport 8095 -j ACCEPT

# Block incoming traffic on Apache’s port (8088)
iptables -A INPUT -p tcp --dport 8088 -j DROP

# Save the changes to the iptables rules
sudo iptables-save | sudo tee /etc/sysconfig/iptables

# Restart the iptables service to apply the changes
systemctl restart iptables

# To list all IPv4 rules
iptables -S
