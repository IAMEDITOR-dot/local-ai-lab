#!/bin/bash

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull a SMALL model that won't cry on CPU
ollama pull llama3:8b

# Install OpenWebUI
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
