#! /bin/bash

service mysql start
mysql -e "CREATE DATABASE steve_db;"
mysql -e "GRANT ALL PRIVILEGES ON steve_db.* TO 'steve_user'@'localhost' IDENTIFIED BY 'password';"
mysql -e "FLUSH PRIVILEGES;"
