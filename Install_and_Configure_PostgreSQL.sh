#!/bin/bash

# a. Install and configure PostgreSQL database on Nautilus database server.
# b. Create a database user kodekloud_rin and set its password to dCV3szSGNA.
# c. Create a database kodekloud_db8 and grant full permissions to user kodekloud_rin on this database.
# d. Make appropriate settings to allow all local clients (local socket connections) to connect to the kodekloud_db8 
    # database through kodekloud_rin user using md5 method (Please do not try to encrypt password with md5sum).
# e. At the end its good to test the db connection using these new credentials from root user or server's sudo user.

# stdb01 	172.16.239.10 	stdb01.stratos.xfusioncorp.com 	peter 	Sp!dy 	Nautilus DB Server

ssh peter@172.16.239.10

sudo yum -y install postgresql-server postgresql-contrib
sudo postgresql-setup initdb

sudo systemctl enable postgresql
sudo systemctl start postgresql

sudo -u postgres psql

CREATE DATABASE kodekloud_db8;
CREATE USER kodekloud_rin WITH ENCRYPTED PASSWORD 'dCV3szSGNA';
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db8 TO kodekloud_rin;
\q

sudo vi /var/lib/pgsql/data/postgresql.conf
listen_addresses = 'localhost'

sudo vi /var/lib/pgsql/data/pg_hba.conf
local   all             all                                     md5
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5

sudo systemctl restart postgresql

psql -U kodekloud_rin -d kodekloud_db8 -h localhost -W

# Done