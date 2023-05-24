# The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. 
# One is to create a bash script for taking websites backup. They have a static website running on App Server 3 in Stratos Datacenter, 
# and they need to create a bash script named news_backup.sh which should accomplish the following tasks. 
# (Also remember to place the script under /scripts directory on App Server 3)

# a. Create a zip archive named xfusioncorp_news.zip of /var/www/html/news directory.
# b. Save the archive in /backup/ on App Server 3. This is a temporary storage, as backups from this 
# location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.
# c. Copy the created archive to Nautilus Backup Server server in /backup/ location.
# d. Please make sure script won't ask for password while copying the archive file. Additionally, 
# the respective server user (for example, tony in case of App Server 1) must be able to run it.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp01 	172.16.238.10 	stapp01.stratos.xfusioncorp.com 	tony 	         	Nautilus App 1
# stapp03 	172.16.238.12 	stapp03.stratos.xfusioncorp.com 	banner 	         	Nautilus App 3
# stbkp01 	172.16.238.16 	stbkp01.stratos.xfusioncorp.com 	clint 	         	Nautilus Backup Server

# Connect to Nautilus App 3
ssh banner@172.16.238.12

# Create file and take permission that needed
touch /scripts/news_backup.sh && chmod +x /scripts/news_backup.sh

# Put some code to the file
cat <<EOF >/scripts/news_backup.sh
#!/bin/bash
zip /backup/xfusioncorp_news.zip /var/www/html/news
scp /backup/xfusioncorp_news.zip clint@172.16.238.16:/backup/
echo "Done"
EOF

# Generate a ssh-key and copy it to the remote server
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub clint@172.16.238.16

# Execute your script
# [banner@stapp03 scripts]$ ./news_backup.sh 
# updating: var/www/html/news/ (stored 0%)
# xfusioncorp_news.zip                                                                                                        100%  186   574.0KB/s   00:00    
