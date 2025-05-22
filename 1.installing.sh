#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

dnf install -y mysql-server

if [ $? -ne 0 ]; then
    echo "Failed to install MySQL server"
    exit 1
fi
