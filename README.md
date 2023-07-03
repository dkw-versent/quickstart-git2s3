# Deployment Steps

![Quick Start architecture for implementing webhooks on AWS](./docs/images/image3.png)

### Prep

0. Authenticate your shell to AWS
1. Create an S3 bucket in your account to store the Lambda zips: `aws s3 mb s3://<NAME>`
2. Navigate to the Lambda source directory: `cd functions/source`
3. Run the packaging script: `bash package.sh <BUCKET_NAME>`

### Deploy the stack

Generate your API secret:

```shell
SECRET="$(python -c 'import secrets;print(secrets.token_urlsafe(64))')"
```

Navigate to the root of the repository and deploy the CloudFormation stack:

```shell
aws cloudformation create-stack \
    --capabilities CAPABILITY_IAM \
    --stack-name ci-spike \
    --template-body file://templates/git2s3.template.yaml \
    --parameters \
    ParameterKey=ApiSecret,ParameterValue="$SECRET" \
    ParameterKey=QSS3BucketName,ParameterValue=NAME_OF_YOUR_BUCKET \
    ParameterKey=VPCId,ParameterValue=YOUR_VPC_ID \
    ParameterKey=VPCCidrRange,ParameterValue=YOUR_VPC_CIDR_RANGE \
    ParameterKey=SubnetIds,ParameterValue=PRIVATE_SUBNET_1_ID,PRIVATE_SUBNET_2_ID
```

### Using the stack

Follow the existing docs at: https://aws-quickstart.github.io/quickstart-git2s3/
