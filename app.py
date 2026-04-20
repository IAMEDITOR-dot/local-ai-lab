from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

OLLAMA_URL = "http://localhost:11434/api/generate"

@app.route("/api/chat", methods=["POST"])
def chat():
    user_msg = request.json.get("message", "")

    payload = {
        "model": "tinyllama",
        "prompt": user_msg,
        "stream": False
    }

    r = requests.post(OLLAMA_URL, json=payload)
    data = r.json()

    return jsonify({"reply": data["response"]})

@app.route("/")
def index():
    return open("index.html").read()

app.run(host="0.0.0.0", port=8081)