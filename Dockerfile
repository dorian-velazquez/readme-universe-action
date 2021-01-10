FROM python:latest

RUN pip install --upgrade pip && \
    pip install jinja2

COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py
COPY templates /templates

RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["/entrypoint.sh"]
