FROM python:latest

ENV TERRAFORM_VERSION=0.13.0

COPY entrypoint.sh /entrypoint.sh

RUN wget https://releases.hashicorp.com/terraform/0.13.0/terraform_$TERRAFORM_VERSION_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip -d /bin

RUN pip install --upgrade pip && \
    pip install jinja2

COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py
COPY templates /templates

RUN chmod 777 /bin/terraform
RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["/entrypoint.sh"]
