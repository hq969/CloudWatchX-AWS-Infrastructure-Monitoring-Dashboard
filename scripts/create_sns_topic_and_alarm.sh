#!/bin/bash

REGION="us-east-1"
TOPIC_NAME="MySNSTopic"
EMAIL="309302519009@bitraipur.ac.in"
INSTANCE_ID="i-uhkk45gfddffggddf"

# Create SNS Topic
aws sns create-topic --name $TOPIC_NAME --region $REGION

# Subscribe
aws sns subscribe \
  --topic-arn arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$TOPIC_NAME \
  --protocol email \
  --notification-endpoint $EMAIL

# Create CloudWatch Alarm
aws cloudwatch put-metric-alarm \
  --alarm-name "HighCPUAlarm" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 60 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 1 \
  --alarm-actions arn:aws:sns:$REGION:$(aws sts get-caller-identity --query Account --output text):$TOPIC_NAME \
  --dimensions Name=InstanceId,Value=$INSTANCE_ID \
  --unit Percent
