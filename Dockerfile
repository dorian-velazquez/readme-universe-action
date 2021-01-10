FROM python:latest

ENV HASHICORP_PATH=https://registry.kroger.com/artifactory/hashicorp-dist
ENV TERRAFORM_VERSION=0.13.0
ENV TF_INPUT=false

# Terraform Providers
ENV NULL_TF_VERSION=2.1.2

COPY entrypoint.sh /entrypoint.sh
COPY dependencies/terragrunt /usr/bin/terragrunt
COPY scripts/ /tmp/

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform

RUN pip install --upgrade pip && \
    pip install jinja2

COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py
COPY templates /templates

RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["/entrypoint.sh"]
