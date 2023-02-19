FROM python:3.9
# docker file starts with statment from then which base image you want to use python:3.9 and then we run command 

RUN pip install pandas
# it will install pandas inside the container and create new image based on that

# we can also overwrite means instead of python prompt we can get bash

WORKDIR /app
# location of image in the container where we copy file

COPY pipeline.py pipeline.py

# ENTRYPOINT [ "bash" ]

# this is simple docker file installed pandas and overwrite the entrypoint

# now instead of enterying into bash mode overwrite with

ENTRYPOINT [ "python" , "pipeline.py" ] 