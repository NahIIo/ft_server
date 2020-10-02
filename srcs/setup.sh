#!bin/bash
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

mkdir /var/www/localhost

####

mkdir /etc/nginx/ssl
openssl req -x509 -newkey rsa:4096 -days 9999 -keyout key.pem -nodes -out /etc/nginx/ssl/cert.pem -keyout /etc/nginx/ssl/ssl.key -subj "/"

####

mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

####

service mysql start
mysql -u root --skip-password << EOF
CREATE DATABASE wordpress_db;
GRANT ALL ON wordpress_db.* TO 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

####

mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyadmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmadmin
mv /tmp/phpmyadmin.conf /var/www/localhost/phpmyadmin/config.inc.php

####

wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress/ /var/www/localhost/
mv /tmp/wp-config.php /var/www/localhost/wordpress

####

service php7.3-fpm start
service nginx restart

# docker build -t ft_server .
# docker run --name MYSERVER -it -p80:80 ft_server
# https://localhost

bash
