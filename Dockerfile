FROM python:latest

ENV TERRAFORM_VERSION=0.13.5

RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    ln -s ~/.tfenv/bin/* /usr/local/bin && \
    tfenv install $TERRAFORM_VERSION && \
    tfenv use $TERRAFORM_VERSION

RUN pip install --upgrade pip && \
    pip install jinja2

COPY terragrunt /bin/terragrunt
COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py
COPY templates /templates

RUN chmod 777 /bin/terragrunt
RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["python","/script.py"]
