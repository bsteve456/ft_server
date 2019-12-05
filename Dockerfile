FROM debian:latest

RUN apt-get update
RUN apt-get -y install vim
RUN apt-get -y install nginx
RUN apt-get -y install openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
	-subj "/CN=localhost" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \ 
	-out /etc/ssl/certs/nginx-selfsigned.crt 
RUN openssl dhparam -out /etc/nginx/dhparam.pem 400
ADD srcs/self-signed.conf  /etc/nginx/snippets/self-signed.conf
ADD srcs/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
RUN rm /etc/nginx/sites-enabled/default
ADD srcs/default /etc/nginx/sites-enabled/default
RUN nginx -t
RUN apt-get -y install mariadb-server mariadb-client
RUN apt-get -y install wget
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-mbstring
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz &&  mv phpMyAdmin-4.9.0.1-all-languages /usr/share/phpMyAdmin
RUN mkdir /usr/share/phpMyAdmin/tmp && chmod 777 /usr/share/phpMyAdmin/tmp/
RUN service php7.3-fpm start
RUN ln -s /usr/share/phpMyAdmin/ /var/www/html/
ADD srcs/phpmyadmin.sh /phpmyadmin.sh
RUN chmod 755 phpmyadmin.sh
ADD srcs/config.inc.php /usr/share/phpMyAdmin/config.inc.php
RUN ./phpmyadmin.sh
ADD srcs/wordpress_user_db.sh /wordpress_user_db.sh
RUN chmod 755 wordpress_user_db.sh
RUN ./wordpress_user_db.sh
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xzvf latest.tar.gz && mv wordpress /usr/share/wordpress
RUN ln -s /usr/share/wordpress/ /var/www/html/
ADD srcs/wp-config.php /usr/share/wordpress/
ADD srcs/start.sh /usr/bin/start.sh
RUN chmod 755 /usr/bin/start.sh
ENTRYPOINT ["start.sh"]

