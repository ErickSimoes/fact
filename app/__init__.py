"""Package with the Application Factory"""

import os
import secrets

from flask import Flask, render_template
from dotenv import load_dotenv


load_dotenv()


def create_app(test_config=None):
    """Application Factory"""

    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY=os.environ['SECRET_KEY'],
        SQLALCHEMY_DATABASE_URI=os.environ['DATABASE_CONNECTION_URI']
    )

    if test_config is None:
        app.config.from_pyfile('config.py', silent=True)
    else:
        app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    @app.route('/hello')
    def hello():
        return render_template('base.html')

    return app
