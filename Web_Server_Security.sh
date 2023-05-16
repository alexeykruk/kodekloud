# During a recent security audit, the application security team of xFusionCorp Industries found security 
# issues with the Apache web server on Nautilus App Server 2 server in Stratos DC. They have listed several 
# security issues that need to be fixed on this server. Please apply the security settings below:

# a. On Nautilus App Server 2 it was identified that the Apache web server is exposing the version number. 
# Ensure this server has the appropriate settings to hide the version number of the Apache web server.

# b. There is a website hosted under /var/www/html/beta on App Server 2. It was detected that the directory 
# /beta lists all of its contents while browsing the URL. Disable the directory browser listing in Apache config.

# c. Also make sure to restart the Apache service after making the changes.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 		        Nautilus App 2


# The first step is to change the website directory in /etc/httpd/conf/httpd.conf

# Connect to servert
ssh steve@172.16.238.11

# Replace the text block
<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>

# On
<Directory /var/www/html/beta/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
        Allow from all
</Directory>

# Replace the line
DocumentRoot "/var/www/html"

# On
DocumentRoot "/var/www/html/beta"

# The second step is to enable httpd service and hide the version number of the Apache web server.
sudo systemctl enable httpd && sudo systemctl start httpd
curl --head http://localhost:8080
sudo sh -c "echo -e 'ServerTokens Prod\nServerSignature Off' >> /etc/httpd/conf/httpd.conf"
sudo systemctl restart httpd

# Check the response head
curl --head http://localhost:8080
