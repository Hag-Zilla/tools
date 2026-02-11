#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

echo "=========================================="
echo "Docker Installation on Ubuntu/Debian"
echo "=========================================="

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "⚠️  Docker is already installed (version $(docker --version))"
    read -p "Do you want to continue and reinstall? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

echo ""
echo "📦 Updating packages and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

echo ""
echo "🔑 Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo ""
echo "📝 Configuring Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo ""
echo "🔄 Updating package list..."
sudo apt-get update

echo ""
echo "🐳 Installing Docker and its components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo ""
echo "👤 Adding user $USER to docker group..."
sudo usermod -aG docker $USER

echo ""
echo "✅ Testing Docker installation..."
sudo docker run hello-world

echo ""
echo "=========================================="
echo "✨ Installation completed successfully!"
echo "=========================================="
echo ""
echo "⚠️  IMPORTANT: To use Docker without sudo, you must:"
echo "   1. Log out of your session"
echo "   2. Log back in"
echo "   OR run: newgrp docker"
echo ""
echo "Installed version: $(docker --version)"
echo ""