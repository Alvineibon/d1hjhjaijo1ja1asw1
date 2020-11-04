 #!/bin/bash
key="Name=tag:Name,Values=$1"
IP=$(aws ec2 describe-instances --filter "$key" --query "Reservations[*].Instances[*].[PublicIpAddress]" --output text --region ap-southeast-1 --profile prod)
if [ -z "$IP" ]
then echo "Host not found"
else ssh ec2-user@$IP
fi