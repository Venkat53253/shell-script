#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

dnf remove -y mysql-server 
if [ $? -ne 0 ]; then
    echo "Failed to remove MySQL server"
    exit 10
fi

dnf remove -y nginx
if [ $? -ne 0 ]; then
    echo "Failed to remove Nginx"
    exit 20
fi