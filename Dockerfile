FROM debian:buster

LABEL maintainer="Julian CHAUVET <jchauvet@student.42.fr"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install apt-utils dialog vim wget openssl

RUN apt-get -y install php7.3-fpm php-cgi php-cli php7.3-mysql

RUN apt-get install nginx -y

RUN apt-get install mariadb-server -y

EXPOSE 80 443

COPY srcs/wordpress.sql /var/www/

COPY srcs /tmp/

CMD bash /tmp/setup.sh

