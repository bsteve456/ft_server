FROM debian:latest
RUN apt-get update && apt-get -y install nginx 
CMD ["nginx", "-g", "daemon off;"]
