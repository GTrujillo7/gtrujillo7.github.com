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

@app.route('/usuario/<last_name>/<name>/<int:age>') #String por default int lo vuelve entero
def usuario(last_name, name, age):
    return "Hola " + last_name + " " + name + " " + str(age) 

# @app.route('/usuario/<username>') #
# def usuario(username):
#    return "Hola " + username

if __name__ == '__main__':
    app.run(debug=True, port=9000)

