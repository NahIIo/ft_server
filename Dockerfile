FROM debian:buster

LABEL maintainer="Julian CHAUVET <jchauvet@student.42.fr"

RUN apt-get update && apt-get -y install dialog apt-utils vim wget openssl

RUN apt-get -y install php7.3-fpm php7.3-mysql php7.3-common php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap zip

RUN apt-get install nginx -y

RUN apt-get install mariadb-server -y

EXPOSE 80 443

COPY srcs/wordpress.sql /var/www/

COPY srcs /tmp/

CMD bash /tmp/setup.sh

