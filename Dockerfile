# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Set the working directory
WORKDIR /app

# Install JupyterLab
RUN pip3 install jupyterlab

# Expose port 443
EXPOSE 443

# Start JupyterLab on port 8080 without authentication
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=443", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
