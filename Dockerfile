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

# Install dlib wheel directly from PyPI, then other requirements
RUN pip install --no-cache-dir https://files.pythonhosted.org/packages/4c/76/2e8e5d3e5e9bf304c9c2cc25a99ea542a101e5a2b2bd62d690e885d718c7/dlib-19.24.2-cp311-cp311-manylinux_2_17_x86_64.whl \
    && pip install --no-cache-dir -r requirements.txt

# Expose port for Render
EXPOSE $PORT

# Run the app with the correct file name
CMD ["python", "help.py"]
