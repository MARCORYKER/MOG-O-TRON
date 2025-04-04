FROM python:3.11-slim

# Install system dependencies for dlib build
RUN apt-get update && apt-get install -y \
    libopenblas-dev \
    liblapack-dev \
    cmake \
    build-essential \
    libpng-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove cmake build-essential libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Expose port for Render
EXPOSE $PORT

# Run the app with the correct file name
CMD ["python", "help.py"]
