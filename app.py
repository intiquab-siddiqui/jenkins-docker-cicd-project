from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Jenkins CI/CD Project v2 is Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
