# Configurations
class development_config():
    DEBUG = True
    SECRET_KEY = "qhrf$edjYTJ)*21nsThdK"

    MYSQL_HOST = "localhost"
    MYSQL_USER = "root"
    MYSQL_PASSWORD = "root"
    MYSQL_DB = "flower_shop"
# Configurations

# Environment Configurations
config = { "development": development_config }
# Environment Configurations