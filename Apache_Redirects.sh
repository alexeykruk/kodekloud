The Nautilus devops team got some requirements related to some Apache config changes. They need to setup some redirects for some URLs. There might be some more changes need to be done. Below you can find more details regarding that:

    httpd is already installed on app server 1. Configure Apache to listen on port 5003.

    Configure Apache to add some redirects as mentioned below:

    a.) Redirect http://stapp01.stratos.xfusioncorp.com:<Port>/ to http://www.stapp01.stratos.xfusioncorp.com:<Port>/ 
    i.e non www to www. This must be a permanent redirect i.e 301

    b.) Redirect http://www.stapp01.stratos.xfusioncorp.com:<Port>/blog/ to http://www.stapp01.stratos.xfusioncorp.com:<Port>/news/. 
    This must be a temporary redirect i.e 302.



# Server Name 	IP 	Hostname 	User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	Ir0nM@n 	Nautilus App 1

sudo systemctl enable httpd && sudo systemctl start httpd

# For Configure Apache to listen on port 5003. Change Listen 8080 to Listen 5003 in /etc/httpd/conf/httpd.conf

sudo vi /etc/httpd/conf/httpd.conf

# Add block if text into /etc/httpd/conf.d/default.conf
sudo vi /etc/httpd/conf.d/default.conf

# Permanent redirect i.e 301
<VirtualHost *:5003>
        ServerName stapp01.stratos.xfusioncorp.com:5003
        Redirect 301 / http://www.stapp01.stratos.xfusioncorp.com:5003/
</VirtualHost>

# Temporary redirect i.e 302.
<VirtualHost *:5003>
        ServerName www.stapp01.stratos.xfusioncorp.com:5003/blog/
        Redirect 302 /blog/ http://www.stapp01.stratos.xfusioncorp.com:5003/news/
</VirtualHost>

# Restart Apache2 server
sudo systemctl restart httpd

# Check it with curl request
curl -LI http://stapp01.stratos.xfusioncorp.com:5003
curl -LI http://www.stapp01.stratos.xfusioncorp.com:5003/blog/
