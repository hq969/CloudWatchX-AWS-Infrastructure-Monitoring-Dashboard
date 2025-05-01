import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = 'i-xxxxxxxxxxxxxxxxx'
    response = ec2.reboot_instances(InstanceIds=[instance_id])
    return {
        'statusCode': 200,
        'body': f"Rebooted instance {instance_id}. Response: {response}"
    }
