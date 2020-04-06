#!/bin/sh

set -e

if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

# Default to us-east-1 if AWS_REGION not set.
if [ -z "$AWS_REGION" ]; then
  AWS_REGION="us-east-1"
fi

# Create a dedicated profile for this action
aws configure --profile s3-copy-action <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

# Copy all files from a folder in a given S3 bucket
sh -c "aws s3 cp s3://${AWS_S3_BUCKET}/${AWS_S3_DIR} . --recursive \
              --profile s3-copy-action \
              --no-progress"

# Clear out credentials
aws configure --profile s3-copy-action <<-EOF > /dev/null 2>&1
null
null
null
text
EOF
