# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt first to leverage Docker cache
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port (change if your app uses a different port)
EXPOSE 5050

# Set environment variables (optional)
# ENV ENV_VAR_NAME=value

# Command to run the application (update as needed)
CMD ["python", "run.py"]
