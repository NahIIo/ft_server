#!bin/bash

mkdir /var/www/localhost

####

mv /tmp/localhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

####

service mysql start

mysql << EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root'
EOF

mysql -u root --password='password' < /var/www/wordpress.sql

####

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.6/phpMyAdmin-4.9.6-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.6-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
rm phpMyAdmin-4.9.6-all-languages.tar.gz

####

cd /tmp/
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/localhost/wordpress
mv /tmp/wp-config.php /var/www/localhost/wordpress/


####

service php7.3-fpm start

####

mkdir ~/mkcert
cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost

####

cd /

service nginx start

bash
