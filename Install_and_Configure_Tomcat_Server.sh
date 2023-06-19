#!/bin/bash 

# The Nautilus application development team recently finished the beta version of one of their Java-based applications, 
# which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have 
# decided to use the tomcat application server. Based on the requirements mentioned below complete the task:

# a. Install tomcat server on App Server 3 using yum.
# b. Configure it to run on port 3002.
# c. There is a ROOT.war file on Jump host at location /tmp. Deploy it on this tomcat server and
#  make sure the webpage works directly on base URL i.e without specifying any sub-directory anything like this http://URL/ROOT .

Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	         	Nautilus App 3

# Connect to server
ssh banner@172.16.238.12

# Install service and service enable 
sudo yum install tomcat
sudo systemctl enable tomcat && sudo systemctl start tomcat

# Put the some changes to tomcat conf
sudo vi /etc/tomcat/server.xml 

# change Connector port
<Connector port="3002" protocol="HTTP/1.1" 
           connectionTimeout="20000" 
           redirectPort="8443" />

# Copy war file from jump host to App3
scp /tmp/ROOT.war banner@172.16.238.12:/usr/share/tomcat/webapps/

#Restart the tomcat service
sudo systemctl restart tomcat

# Check the service response
curl http://172.16.238.12:3002

# Done
