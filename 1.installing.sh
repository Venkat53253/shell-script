#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

dnf -y install mysql-server
if [ $? -ne 0 ]; then
    echo "Failed to install MySQL server"
    exit 10
    fi

dnf -y install nginx
if [ $? -ne 0 ]; then
    echo "Failed to install Nginx"
    exit 20
fi

dnf list installed
if [ $? -ne 0 ]; then
    echo "Failed to list installed packages"
    exit 30
fi
