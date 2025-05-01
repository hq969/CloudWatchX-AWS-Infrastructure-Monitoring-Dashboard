#!/bin/bash

# === Configuration ===
INSTANCE_ID="i-xxxxxxxxxxxxxxxxx"          # Replace with your EC2 instance ID
ALARM_NAME="HighCPUAlarm"
SNS_TOPIC_ARN="arn:aws:sns:us-east-1:123456789012:MySNSTopic"  # Replace with your SNS topic ARN
REGION="us-east-1"
THRESHOLD=80
EVALUATION_PERIODS=1
PERIOD=60
COMPARISON_OPERATOR="GreaterThanThreshold"
METRIC_NAME="CPUUtilization"
NAMESPACE="AWS/EC2"
STATISTIC="Average"

# === Create the Alarm ===
aws cloudwatch put-metric-alarm \
  --alarm-name "$ALARM_NAME" \
  --metric-name "$METRIC_NAME" \
  --namespace "$NAMESPACE" \
  --statistic "$STATISTIC" \
  --period "$PERIOD" \
  --threshold "$THRESHOLD" \
  --comparison-operator "$COMPARISON_OPERATOR" \
  --evaluation-periods "$EVALUATION_PERIODS" \
  --alarm-actions "$SNS_TOPIC_ARN" \
  --dimensions Name=InstanceId,Value="$INSTANCE_ID" \
  --unit Percent \
  --region "$REGION"

echo "Alarm '$ALARM_NAME' created for EC2 instance '$INSTANCE_ID'."
