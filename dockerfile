# Use the official CUDA-enabled image with development tools
FROM ubuntu

# Set the working directory to /app
WORKDIR /app

# Install system dependencies using apt
RUN apt-get update && apt-get install -y gcc

# Install Python and pip
RUN apt-get install -y python3 python3-pip

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
