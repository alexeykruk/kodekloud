echo "The backup server in the Stratos DC contains several template XML files used by the Nautilus application. \
However, these template XML files must be populated with valid data before they can be used. One of the daily tasks \
of a system admin working in the xFusionCorp industries is to apply string and file manipulation commands! \
Replace all occurances of the string `Random` to `Cloud` on the XML file /root/nautilus.xml located in the backup server."

#   Server Name 	IP 	            Hostname 	                        User 	Password 	Purpose
# 	stbkp01         172.16.238.16 	stbkp01.stratos.xfusioncorp.com 	clint               Nautilus Backup Server

ssh -t clint@172.16.238.16 "sudo cat /root/nautilus.xml | grep Random | wc -l && \
sudo sed -i 's/Random/Cloud/' /root/nautilus.xml' && \
sudo cat /root/nautilus.xml | grep Random | wc -l"
