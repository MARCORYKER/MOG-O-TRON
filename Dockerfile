# Use Python 3.10 slim image (better wheel support for dlib)
FROM python:3.10-slim

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
    libjpeg-dev \
    libx11-dev \
    libatlas-base-dev \
    gfortran \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove cmake build-essential libpng-dev libjpeg-dev libx11-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the project files
COPY . .

# Expose port for Render
EXPOSE $PORT

# Run the app with gunicorn (since you have it in requirements.txt)
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "help:app"]
