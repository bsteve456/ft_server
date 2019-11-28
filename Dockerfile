FROM debian:latest
RUN apt-get update
RUN apt-get -y install wget 
RUN apt-get -y install nginx
RUN apt-get -y install default-mysql-server
ADD srcs/start.sh /usr/bin/start.sh
RUN chmod 755 /usr/bin/start.sh
#	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz \
#	&& tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz && mv phpMyAdmin-4.9.0.1-all-languages /usr/share/phpMyAdmin
EXPOSE 80
ENTRYPOINT ["start.sh"]
#CMD ["bash"]
