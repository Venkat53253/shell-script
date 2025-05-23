#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SECURITY_GROUP="sg-066d322d0b8ea9c8f"
INSTANCE=("mongodb" "redis" "mysql" "rabbitmq" "frontend" "payment" "shipping" "catalogue" "user" "dispatch" "cart" "payment")
ZONE_ID="Z05167558BEIFU213OL8"
DOMAIN_NAME="venaws.site"

for i in "${INSTANCE[@]}"; do
  INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-066d322d0b8ea9c8f --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$i}]" --query "Instances[0].InstanceId" --output text)

    if [ "$i" != "frontend" ]; then
        IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$i" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$i" --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "IP address for $i is $IP"

done
