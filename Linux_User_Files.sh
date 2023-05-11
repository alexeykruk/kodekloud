#!/bin/bash
ssh -t steve@172.16.238.11 'find /home/usersdata/ -user yousuf -exec cp --parents {} /beta \;'
