FROM debian:latest
	RUN apt-get update && apt-get install wget -y && \
	apt-get update && apt install default-mysql-server -y && \
	service mysql start && mysql && \
	apt-get update && apt-get upgrade && apt-get install nginx -y
	COPY srcs/  /usr/share/nginx/html
	
