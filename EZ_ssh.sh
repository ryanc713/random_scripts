#!/bin/bash
# Author: Ryan Cook
# Description: EZ SSH Login to Server
# Date: 01-04-2021

ip=REMOTE_HOST_IP
id=/PATH/TO/PRIVATE/KEY
p=PORT
u=USER

ssh -i $id -p $p $u@$ip
