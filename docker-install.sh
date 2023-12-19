#!/bin/bash

# Update the package list
sudo apt-get update

# Install dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock



# Clone the GitHub repository
git clone https://github.com/bvk12/docker-image.git /docker-image

# Change to the directory containing the Dockerfile
cd /docker-image

# Build the Docker image
docker build -t apache-app .

# Run a Docker container (replace 'your-container-name' with a meaningful name)
docker run -d --name apache -p 80:80 apache-app

# Print the external IP address of the instance for accessing the container
EXTERNAL_IP=$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google")
echo "Docker container is running at: http://${EXTERNAL_IP}"


#cd /

# Build the Docker image using the Dockerfile in the root directory
#sudo docker build -t apache-app .

# Run a Docker container based on the built image (replace 'your-container-name' with a meaningful name)
#sudo docker run -d --name apache -p 80:80 apache-app

# Print the external IP address of the instance for accessing the container
#EXTERNAL_IP=$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google")
#echo "Docker container is running at: http://${EXTERNAL_IP}"