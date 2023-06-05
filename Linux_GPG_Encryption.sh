#!/bin/bash

# We have confidential data that needs to be transferred to a remote location, so we need to encrypt that data.
# We also need to decrypt data we received from a remote location in order to understand its content.

# On storage server in Stratos Datacenter we have private and public keys stored /home/*_key.asc. Use those keys to perform the following actions.

# Encrypt /home/encrypt_me.txt to /home/encrypted_me.asc.

# Decrypt /home/decrypt_me.asc to /home/decrypted_me.txt. (Passphrase for decryption and encryption is kodekloud).


# Server Name 	IP 	        Hostname 	                        User 	    Password 	Purpose
# ststor01 	172.16.238.15 	ststor01.stratos.xfusioncorp.com 	natasha 	         	Nautilus Storage Server

# Connect to server
ssh natasha@172.16.238.15

gpg --import /home/public_key.asc
gpg --list-keys kodekloud@kodekloud.com

# Encrypt the File:
gpg --recipient kodekloud@kodekloud.com --output /home/encrypted_me.asc --encrypt /home/encrypt_me.txt

# Decrypt the File:
gpg --output /home/decrypted_me.txt --decrypt /home/decrypt_me.asc
