FROM python:latest

COPY entrypoint.sh /entrypoint.sh

RUN chmod 777 entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]