# Use a Python base image
FROM python:3.11-slim

# Install Node.js 20 and other necessary tools
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port Railway will use
EXPOSE $PORT

# Start the application using the full path to uvicorn
CMD ["sh", "-c", "python -m uvicorn reanime:app --host 0.0.0.0 --port $PORT"]
