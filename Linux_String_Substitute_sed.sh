#!/bin/bash

# There is some data on Nautilus App Server 2 in Stratos DC. Data needs to be altered in several of the files. 
# On Nautilus App Server 2, alter the /home/BSD.txt file as per details given below:
# a. Delete all lines containing word `software` and save results in /home/BSD_DELETE.txt file. (Please be aware of case sensitivity)
# b. Replace all occurrence of word `from` to `is` and save results in /home/BSD_REPLACE.txt file.
# Note: Let's say you are asked to replace word to with from. In that case, 
# make sure not to alter any words containing this string; for example upto, contributor etc.

# Server Name 	IP 	        Hostname 	                        User 	Password 	Purpose
# stapp02 	172.16.238.11 	stapp02.stratos.xfusioncorp.com 	steve 	         	Nautilus App 2

delete_world='software'
replace_word='from'
replace_on_word='is'

ssh -t steve@172.16.238.11 "sudo touch /home/BSD_DELETE.txt && sudo chmod a+w /home/BSD_DELETE.txt && \
    sudo sed '/${delete_world}/d' /home/BSD.txt > /home/BSD_DELETE.txt && \
    cat /home/BSD_DELETE.txt | grep ${delete_world} | wc -l"

ssh -t steve@172.16.238.11 "sudo touch /home/BSD_REPLACE.txt && sudo chmod a+w /home/BSD_REPLACE.txt && \
    sudo sed 's/\b${replace_word}\b/${replace_on_word}/g' /home/BSD.txt > /home/BSD_REPLACE.txt && \
    cat /home/BSD_REPLACE.txt | grep ${replace_word} | wc -l && cat /home/BSD_REPLACE.txt | grep ${replace_on_word} | wc -l"
