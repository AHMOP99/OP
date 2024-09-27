# Use an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    && apt-get clean

# Set the VNC password (change "yourpassword" to a strong password)
RUN mkdir -p /root/.vnc && \
    echo "yourpassword" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Expose the VNC port
EXPOSE 5901

# Start the VNC server
CMD ["bash", "-c", "vncserver :1 -geometry 1280x720 -depth 24 && tail -f /root/.vnc/*.log"]
