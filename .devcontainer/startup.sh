#!/bin/bash

set -e

# dependencies
sudo apt-get update
sudo apt-get install -y zstd curl docker.io

# start docker
sudo service docker start

# install ollama if missing
if ! command -v ollama &> /dev/null; then
  curl -fsSL https://ollama.com/install.sh | sh
fi

# start ollama in background
nohup ollama serve > ollama.log 2>&1 &

sleep 5

# pull a small fast model
ollama pull tinyllama

# start OpenWebUI
docker run -d \
  -p 3000:8080 \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
