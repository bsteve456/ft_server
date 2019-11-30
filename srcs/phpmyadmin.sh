#! /bin/bash
service mysql start
mysql < /usr/share/phpMyAdmin/sql/create_tables.sql -u root
mysql -e "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'pmapass';"
mysql -e "FLUSH PRIVILEGES;"
