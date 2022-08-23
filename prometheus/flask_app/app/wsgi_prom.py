from flask import Flask, request, Response
from prometheus_client import Counter, generate_latest

COUNTER = Counter('app_requests', 'App Requests')

app = Flask(__name__)

@app.route("/")
def hello():
    COUNTER.inc()
    return "Scrape me"

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), 200, mimetype="text/plain")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5005)    