FROM python:3.7-alpine

LABEL "com.github.actions.name"="Copy filed from AWS S3 bucket"
LABEL "com.github.actions.description"="GitHub action to copy files from AWS S3 bucket"
LABEL "com.github.actions.icon"="copy"
LABEL "com.github.actions.color"="green"

LABEL version="0.1.0"
LABEL repository="https://github.com/akasiakin/copy-files-from-s3"
LABEL homepage="https://github.com/akasiakin"
LABEL maintainer="A.V.Kasiakin"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.18.14'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
