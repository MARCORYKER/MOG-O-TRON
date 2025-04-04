# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt first to leverage Docker caching
COPY requirements.txt .

# Install system dependencies for dlib build and Python dependencies
RUN apt-get update && apt-get install -y \
    libopenblas-dev \
    liblapack-dev \
    cmake \
    build-essential \
    libpng-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove cmake build-essential libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the project files
COPY . .

# Expose port for Render
EXPOSE $PORT

# Run the app with the correct file name
CMD ["python", "help.py"]
