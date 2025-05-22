# Dockerfile-for-Python-3.12-PyTorch-Environment

Dockerfile:

* **`FROM python:3.12-slim`**: Specifies Python 3.12 slim version as the base image.
* **`WORKDIR /app`**: Sets the working directory inside the container.
* **`RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*`**: Updates package lists and installs `build-essential` for compiling any necessary C/C++ extensions for the Python packages.
* **`COPY requirements.txt .`**: Copies your `requirements.txt` file into the container.
* **`RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu`**: This command installs the CPU-only versions of PyTorch, torchvision, and torchaudio. Using the `--index-url` ensures you get official builds. If you need GPU support (CUDA), you would change this line according to the instructions on the [PyTorch website](https://pytorch.org/get-started/locally/).
* **`RUN pip install --no-cache-dir -r requirements.txt`**: Installs the remaining packages listed in `requirements.txt` (pandas and numpy).

**To use this Dockerfile:**

1.  Save the first block of code as `Dockerfile` in a new directory.
2.  Save the second block of code as `requirements.txt` in the *same* directory.
3.  Open your terminal, navigate to that directory, and run the build command:
    `docker build -t python-pytorch-env .`
    (This will build the image and tag it as `python-pytorch-env`)
4.  Once the build is complete, you can run a container:
    `docker run -it --rm python-pytorch-env bash`
    (This starts an interactive bash shell in the container.)

Inside the container with eval.py file, you can verify the installations

This will give you a clean environment with Python 3.12 and the specified libraries.
