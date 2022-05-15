import flask
import string
import random


app = flask.Flask(__name__)
db = {}


@app.route("/api/token")
def register():
    alphabet = string.ascii_uppercase + string.digits
    token = "".join(random.choice(alphabet) for i in range(0, 16))
    db[token] = {}
    return {
        "success": "ok",
        "token": token
    }


@app.route("/api/<token>/get/<key>")
def get(token, key):
    if token not in db:
        return {
            "success": "error",
            "error": "no such token registred"
        }
    if key not in db[token]:
        return {
            "success": "error",
            "error": "no such key added"
        }
    return db[token][key]


@app.route("/api/<token>/list")
def list(token):
    import re

    if token not in db:
        return {
            "success": "error",
            "error": "no such token registred"
        }
    return f"""
        <ul>
            {"".join(f"<li><a href='/api/{token}/get/{k}>{re.sub('_', ' ', k)}</li>" for k in db[token].keys())}
        </ul>
    """


@app.route("/api/<token>/add", methods=["POST"])
def add(token):
    if token not in db:
        return {
            "success": "error",
            "error": "no such token registred"
        }
    key = flask.request.form.get("key")
    content = flask.request.form.get("content")
    if any(k not in string.ascii_lowercase + string.digits for k in key):
        return {
            "success": "error",
            "error": "wrong key format"
        }
    db[token][key] = content
    return {
        "success": "ok",
        "key": key
    }