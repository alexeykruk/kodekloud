#!/bin/bash

# xFusionCorp Industries has planned to set up a common email server in Stork DC. After several meetings and 
# recommendations they have decided to use postfix as their mail transfer agent and dovecot as an IMAP/POP3 server. 
# We would like you to perform the following steps:
#     Install and configure postfix on Stork DC mail server.
#     Create an email account james@stratos.xfusioncorp.com identified by 8FmzjvFU6S.
#     Set its mail directory to /home/james/Maildir.
#     Install and configure dovecot on the same server.

# stmail01 	172.16.238.17 	stmail01.stratos.xfusioncorp.com 	groot 	Gr00T123 	Nautilus Mail Server

# Connect to server
ssh groot@172.16.238.17

# Install it on Red Hat distributions
sudo yum install -y postfix

#  Run it and activate it on system start-up
sudo systemctl enable postfix

# Configure Linux Mail Server
sudo vi /etc/postfix/main.cf

myhostname = stmail01.stratos.xfusioncorp.com
mydomain = stratos.xfusioncorp.com
myorigin = $mydomain
mynetworks = 172.16.238.0/24, 127.0.0.0/8
inet_interface = all
#inet_interface = localhost
home_mailbox = Maildir/
#mydestination = $myhostname, localhost.$mydomain, localhost
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

# Reload the postfix configuration and check
sudo systemctl start postfix
sudo postfix check

# Create a mailbox
sudo adduser james
sudo passwd james

# Test email from Terminal
telnet 127.0.0.1 25

mail from: james@stratos.xfusioncorp.com
rcpt to: james@stratos.xfusioncorp.com
data 
Hello
.
quit

# Dovecot Installation
sudo dnf -y install dovecot

#  Run the service and activate it at start-up
sudo systemctl start dovecot && sudo systemctl enable dovecot

# Configure Dovecot
sudo vi /etc/dovecot/dovecot.conf
protocols = imap pop3
listen = *, ::

# Configure the location of the Mailbox
sudo vi /etc/dovecot/conf.d/10-mail.conf
mail_location = maildir:~/Maildir

# Configure the authentication process
sudo vi /etc/dovecot/conf.d/10-auth.conf
disable_plaintext_auth = yes
auth_mechanisms = plain login

# Configure Postfix authentication
sudo vi /etc/dovecot/conf.d/10-master.conf

service auth {
    unix_listener auth-userdb {
        user = postfix
        group = postfix
    }
}

sudo systemctl restart dovecot && sudo systemctl status dovecot

# Test email from Terminal
telnet stmail01 110

user james
pass 8FmzjvFU6S
retr 1
.
quit

# Done
