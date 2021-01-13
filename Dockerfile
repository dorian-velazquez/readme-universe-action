FROM python:latest

RUN pip install --upgrade pip && \
    pip install jinja2

COPY script.py /script.py
COPY templates /templates

RUN chmod 777 script.py
RUN chmod 777 templates

ENTRYPOINT ["python","/script.py"]
