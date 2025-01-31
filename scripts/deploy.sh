#!/bin/bash

STACK_NAME="amazon-connect-stack"
TEMPLATE_FILE="templates/instance.json"
REGION="us-east-1"

echo "Deploying Amazon Connect Stack..."
aws cloudformation deploy --stack-name $STACK_NAME --template-file $TEMPLATE_FILE --capabilities CAPABILITY_NAMED_IAM --region $REGION

echo "Deployment Completed!"
