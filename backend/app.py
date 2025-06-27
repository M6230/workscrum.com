from flask import Flask
from flask_cors import CORS 
from flask_mysqldb import MySQL 
from routes import registrar_rutas
from flask_jwt_extended import JWTManager
from config import config
from datetime import timedelta

app = Flask(__name__)
CORS(app)
app.config.from_object(config)
mysql = MySQL(app)

app.config['JWT_SECRET_KEY'] = 'priprapri'  
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(days=1)
jwt = JWTManager(app)

app.mysql = mysql

registrar_rutas(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
