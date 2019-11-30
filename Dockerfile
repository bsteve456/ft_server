FROM debian:latest
RUN apt-get update
RUN apt-get -y install vim
RUN apt-get -y install nginx
RUN	service nginx start
RUN apt-get -y install mariadb-server mariadb-client
RUN apt-get -y install wget
RUN service mysql start
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-mbstring
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz &&  mv phpMyAdmin-4.9.0.1-all-languages /usr/share/phpMyAdmin
RUN service php7.3-fpm start
RUN rm /etc/nginx/sites-enabled/default
ADD srcs/default.conf /etc/nginx/conf.d/
RUN nginx -t
RUN service nginx reload
ADD srcs/info.php /usr/share/nginx/html/
RUN ln -s /usr/share/phpMyAdmin/ /usr/share/nginx/html/
ADD srcs/create_user_database_sql.sh /create_user_database_sql.sh
RUN chmod 755 create_user_database_sql.sh
RUN ./create_user_database_sql.sh
ADD srcs/start.sh /usr/bin/start.sh
RUN chmod 755 /usr/bin/start.sh
EXPOSE 80
ENTRYPOINT ["start.sh"]
CMD ["bash"]
