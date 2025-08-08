# Start from the official Python Dev Container base image
FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

# Install Node.js 22 via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pyright
RUN npm install -g npm@latest && \
    npm install -g pyright

# Upgrade pip
RUN pip install --upgrade pip

# Add the user install directory to path
ENV PATH="/home/vscode/.local/bin:$PATH"
