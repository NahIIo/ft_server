echo -e "\e[44m__________________ STARTING SETUP __________________\e[0m";

#!bin/bash

mkdir /var/www/localhost

####

mv /tmp/localhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

####

echo -e "\e[44m__________________ Setting up MYSQL __________________\e[0m";
service mysql start

mysql << EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='user';
EOF

mysql -u user --password='password' < /var/www/wordpress.sql;
echo -e "\e[42m__________________ MYSQL Setup Finished __________________\e[0m";
sleep .5;

####

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

echo -e "\e[44m__________________ Setting up PHPMyAdmin __________________\e[0m";

mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.6/phpMyAdmin-4.9.6-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.6-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
rm phpMyAdmin-4.9.6-all-languages.tar.gz

echo -e "\e[42m__________________ PHPMyAdmin Setup Finished __________________\e[0m";

####

echo -e "\e[44m__________________ Setting up Wordpress __________________\e[0m";

cd /tmp/
wget https://fr.wordpress.org/wordpress-5.5.2-fr_FR.tar.gz
tar -xvzf wordpress-5.5.2-fr_FR.tar.gz
mv wordpress/ /var/www/localhost/wordpress
mv /tmp/wp-config.php /var/www/localhost/wordpress/

echo -e "\e[42m__________________ Wordpress Setup Finished __________________\e[0m";


####

service php7.3-fpm start

####

echo -e "\e[44m__________________ Setting up SSH __________________\e[0m";

mkdir ~/mkcert
cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost
chmod -x mkcert

echo -e "\e[42m__________________ SSH Setup Finished __________________\e[0m";

####

cd /
chmod -w /tmp/autoindex/*

echo -e "\e[42m__________________ GOOD TO GO ! __________________\e[0m";

service nginx start

bash
