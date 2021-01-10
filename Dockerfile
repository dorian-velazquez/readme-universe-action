FROM python:latest

ENV HASHICORP_PATH=https://registry.kroger.com/artifactory/hashicorp-dist
ENV TERRAFORM_VERSION=0.13.0
ENV TF_INPUT=false

# Terraform Providers
ENV NULL_TF_VERSION=2.1.2

COPY entrypoint.sh /entrypoint.sh
COPY dependencies/terragrunt /usr/bin/terragrunt
COPY scripts/ /tmp/

RUN wget https://releases.hashicorp.com/terraform/0.13.0/terraform_$TERRAFORM_VERSION_linux_amd64.zip -O terraform.zip
    unzip terraform.zip -d .

RUN pip install --upgrade pip && \
    pip install jinja2

COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py
COPY templates /templates

RUN chmod 777 terraform
RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["/entrypoint.sh"]
