# Use the official Python 3.9 slim image as a base
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Update package list and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jre-headless wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN pip install --no-cache-dir \
    pyspark \
    google-cloud-bigquery \
    slack-sdk

# Copy the rest of the application code into the container
COPY . .

# Define the default command to run the container
CMD ["python", "-c", "print('Container is ready to run your Spark application')"]
