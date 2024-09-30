# Use the official Python 3.9 slim image as a base
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Update package list and install dependencies
# Update the OS packages
RUN apt update \
    && apt upgrade \
    && apt install curl -y \
# This removes packages that can no longer be downloaded
    && apt autoclean -y \ 
# This removes dependencies of packages that are no longer installed
    && apt autoremove -y

RUN pip install --upgrade pip
RUN apt-get install default-jdk -y
RUN pip install pyspark google-cloud-bigquery
RUN pip -V \
    && python -V
# Verify that the image does not have conflicting dependencies.
RUN pip check


# Copy the rest of the application code into the container
COPY . .

# Define the default command to run the container
CMD ["python", "-c", "print('Container is ready to run your Spark application')"]
