#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

dnf -y install mysql-serverr
if [ $? -ne 0 ]; then
    echo "Failed to install MySQL server"
    exit 10
    fi

dnf -y install nginxx
if [ $? -ne 0 ]; then
    echo "Failed to install Nginx"
    exit 20
fi