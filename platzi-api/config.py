import os


class Config(object):
    DEBUG = True
    SECRET_KEY = 'dev'
    PLATZI_DB_URI = os.environ['PLATZI_DB_DEV_URI'] if os.environ['FLASK_ENV'] == 'development' else os.environ['PLATZI_DB_URI']


class DevelopmentConfig(Config):
    DEBUG = False
