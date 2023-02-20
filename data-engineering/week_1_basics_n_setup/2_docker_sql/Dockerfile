FROM python:3.9
# docker file starts with statment from then which base image you want to use python:3.9 and then we run command 
# psycopg2 is library for python accesing postgres
# we need to install wget becauwe we have used that
RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2
# it will install pandas inside the container and create new image based on that

# we can also overwrite means instead of python prompt we can get bash

WORKDIR /app
# location of image in the container where we copy file

COPY ingest_data.py ingest_data.py

# ENTRYPOINT [ "bash" ]

# this is simple docker file installed pandas and overwrite the entrypoint

# now instead of enterying into bash mode overwrite with

ENTRYPOINT [ "python" , "ingest_data.py" ] 