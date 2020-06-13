from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route('/')
def index():
    name= "Jaime"
    lastname="Lopez"

    return render_template("index.html", username=name,
                                         userlast=lastname)

if __name__ == '__main__':
    app.run(debug=True, port=9000)

