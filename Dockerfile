# Use an official Python 3.12 runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies that might be required by the Python libraries.
# PyTorch might need some, and build-essential is good for general C/C++ extensions.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python libraries
# We copy the requirements.txt file first to leverage Docker cache
COPY requirements.txt .

# Install PyTorch first, often recommended to ensure compatibility with CUDA if used,
# though for a CPU-only build like this, it's less critical but still good practice.
# Visit https://pytorch.org/get-started/locally/ for specific pip commands if you need
# a version with CUDA or other specific features.
# This command installs the CPU-only version of PyTorch.
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# (Optional) You can copy your application code here
# COPY . .

# (Optional) Command to run when the container starts
# CMD ["python", "your_script.py"]

# This Dockerfile assumes a requirements.txt file exists in the same directory
# with the following content (excluding torch, as it's installed separately):
# pandas
# numpy
