
FROM python:3.10.6


WORKDIR /app

RUN pip install pandas

COPY pipeline.py pipeline.py

# ENTRYPOINT [ "bash" ]

ENTRYPOINT [ "python", "pipeline.py" ]