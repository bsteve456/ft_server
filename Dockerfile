FROM debian:latest
RUN apt-get update
RUN apt-get -y install vim
RUN apt-get -y install nginx
RUN	service nginx start
RUN apt-get -y install mariadb-server mariadb-client
RUN service mysql start
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline
RUN service php7.3-fpm start
RUN rm /etc/nginx/sites-enabled/default
ADD srcs/default.conf /etc/nginx/conf.d/
RUN nginx -t
RUN service nginx reload
ADD srcs/info.php /usr/share/nginx/html/
ADD srcs/start.sh /usr/bin/start.sh
RUN chmod 755 /usr/bin/start.sh
EXPOSE 80
ENTRYPOINT ["start.sh"]
CMD ["bash"]
