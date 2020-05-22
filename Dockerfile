FROM python:3

RUN pip install black

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]