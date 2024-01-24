# Use the official CUDA-enabled image with development tools
FROM nvidia/cuda:12.3.1-base-ubuntu20.04

# Set the working directory to /app
WORKDIR /app

# Install system dependencies using apt
RUN apt-get update && apt-get install -y gcc

# Install additional libraries for graphical support
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0 libsm6 libxext6 libxrender1

# Install Python and pip
RUN apt-get install -y python3 python3-pip

# Install CUDA-related libraries
RUN apt-get install -y libcublas-dev-11-4 libcudnn8=8.2.4.15-1+cuda11.4 libnccl2=2.10.3-1+cuda11.4 libcurand10 libcufft10


# Copy the requirements.txt file into the container at /app
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Set the environment variable to use GPU for onnxruntime
ENV ONNXRUNTIME_CUDA=True

# Expose port 8501 for Streamlit
EXPOSE 8501

# Copy the current directory contents into the container at /app
COPY . /app

# Command to run the application
CMD ["streamlit", "run", "--server.port", "8501", "main.py"]
