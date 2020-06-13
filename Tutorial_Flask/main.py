from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route('/')
def index():
    name= "Jaime"
    lastname="Lopez"
    is_premium = True
    courses = ["Python", "Ruby","Java", "Elixir"]

    return render_template("index.html", username=name,
                                         userlast=lastname,
                                         is_premium=is_premium,
                                         courses=courses)
if __name__ == '__main__':
    app.run(debug=True, port=9000)

