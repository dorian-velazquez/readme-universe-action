FROM python:latest

ENV TERRAFORM_VERSION=0.13.5

RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    ln -s ~/.tfenv/bin/* /usr/local/bin && \
    tfenv install $TERRAFORM_VERSION && \
    tfenv use $TERRAFORM_VERSION


COPY terragrunt /bin/terragrunt
COPY entrypoint.sh /entrypoint.sh

RUN chmod 777 /bin/terragrunt
RUN chmod 777 entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
