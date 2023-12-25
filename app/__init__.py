"""Package with the Application Factory"""

import os
import secrets

from flask import Flask, render_template
from dotenv import load_dotenv


load_dotenv()

def get_secret_key(path: str = '.flask_secret') -> str:
    """Returns a token from the file, or generates a new one

    :param path: Path to the secret file. Default is ``'.flask_secret'``

    :return: The key as ``str``.
    """

    try:
        with open(path, encoding='UTF-8') as secret_file:
            return secret_file.read()
    except FileNotFoundError:
        with open(path, 'w', encoding='UTF-8') as secret_file:
            token = secrets.token_hex(64)
            secret_file.write(token)
            return token


def create_app(test_config=None):
    """Application Factory"""

    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY=get_secret_key(),
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
