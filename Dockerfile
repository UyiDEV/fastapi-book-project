# Use an official Python runtime as the base image
FROM python3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

FROM nginx:alpine

# Copy nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]