#!/bin/bash
set -e

echo "Installing system packages..."
sudo apt-get update
sudo apt-get install -y zstd curl python3 python3-pip

echo "Installing Ollama if missing..."
if ! command -v ollama &> /dev/null; then
  curl -fsSL https://ollama.com/install.sh | sh
fi

echo "Starting Ollama server in background..."
nohup ollama serve > ollama.log 2>&1 &

sleep 5

echo "Pulling fast tiny model..."
ollama pull tinyllama

echo "Installing Python backend..."
pip3 install flask requests

echo "Starting chat web app..."
nohup python3 app.py > web.log 2>&1 &

echo "Setup complete. Open port 8081."