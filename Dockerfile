FROM python:latest

RUN ["/bin/bash","pip","install","jinja2"]

COPY entrypoint.sh /entrypoint.sh
COPY script.py /script.py

RUN chmod 777 entrypoint.sh
RUN chmod 777 script.py

ENTRYPOINT ["/entrypoint.sh"]
