FROM python:3.11-slim

# Install minimal system dependencies
RUN apt-get update && apt-get install -y \
    libopenblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dlib wheel directly, then other requirements
RUN pip install --no-cache-dir https://github.com/jloh02/dlib/releases/download/v19.24.2/dlib-19.24.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl \
    && pip install --no-cache-dir -r requirements.txt

# Expose port for Render
EXPOSE $PORT

# Run the app with the correct file name
CMD ["python", "help.py"]
