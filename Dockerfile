FROM public.ecr.aws/lambda/provided:latest

RUN yum update -y && yum install -y unzip tar gzip zip

ARG TERRAFORM_VERSION=0.15.3

WORKDIR /root

RUN mkdir /opt/bin

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /opt/bin/
RUN cd /opt/bin && unzip *.zip && rm -rf *.zip

RUN /opt/bin/terraform --version

# wrap it up
RUN cd /opt; zip --symlinks -r ../layer.zip ./; \
    echo "/layer.zip is ready"; \
    ls -alh /layer.zip;

# get the version number
RUN /opt/bin/terraform --version 2>&1 | tee /TERRAFORM_VERSION
