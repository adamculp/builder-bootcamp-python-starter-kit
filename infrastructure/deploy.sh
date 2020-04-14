#!/usr/bin/env bash

set -e
set -u

cd $(dirname $0)

# Configuration
CodeCommitRepoName=builder-bootcamp-nodejs-starter-kit
StackName=bootcamp-starter-kit-infra
BucketName=bootcamp-starter-kit-$USER
Region=us-east-1

# Package and deploy
aws cloudformation package \
--template-file service.yaml \
--s3-bucket ${BucketName} \
--output-template-file packaged-${StackName}-template.yaml \
--region ${Region}

aws cloudformation deploy \
--stack-name ${StackName} \
--template-file packaged-${StackName}-template.yaml \
--parameter-overrides \
"CodeCommitRepoName=${CodeCommitRepoName}" \
--s3-bucket ${BucketName} \
--capabilities CAPABILITY_IAM \
--region ${Region}

# Display CodeCommit repository URL
aws codecommit get-repository --repository-name ${CodeCommitRepoName} \
--output text | awk '{print $4}'