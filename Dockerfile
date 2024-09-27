# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Set the working directory
WORKDIR /app

# Install Jupyter Notebook
RUN pip3 install notebook

# Expose port 8888
EXPOSE 8888

# Start Jupyter Notebook on port 8888 without authentication
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
