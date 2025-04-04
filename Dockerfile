FROM python:3.11-slim

# Install system dependencies for dlib and OpenCV
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies with custom CMake args for dlib
RUN pip install --no-cache-dir -r requirements.txt --global-option="build_ext" --global-option="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

# Expose port for Render
EXPOSE $PORT

# Run the app
CMD ["python", "app.py"]
