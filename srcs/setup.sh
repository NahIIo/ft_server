# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Julian <Julian@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/21 09:55:21 by Julian            #+#    #+#              #
#    Updated: 2021/01/21 14:44:46 by Julian           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo -e "\e[34m┌─────────────────────────────────────────────────────┐\e[0m";
echo -e "\e[34m│\e[0m                  \e[1mSTARTING SETUP !\e[0m                   \e[34m│\e[0m";
echo -e "\e[34m└─────────────────────────────────────────────────────┘\e[0m";
#!/bin/bash

mkdir /var/www/localhost

####

mv /tmp/localhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

####

echo -e "Setting up MYSQL ..";
service mysql start

mysql << EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='user';
EOF

mysql -u user --password='password' < /var/www/wordpress.sql;
echo -e "MYSQL Setup Finished.";
echo -e "\0"

####f

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

echo -e "Setting up PHPMyAdmin ..";

mkdir /var/www/localhost/phpmyadmin
echo -e "[.   ] Ongoing"
wget -q https://files.phpmyadmin.net/phpMyAdmin/4.9.6/phpMyAdmin-4.9.6-all-languages.tar.gz
echo  -en "[... ] Ongoing"
tar -xf phpMyAdmin-4.9.6-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
rm phpMyAdmin-4.9.6-all-languages.tar.gz

echo -e "\0"
echo -e "PHPMyAdmin Setup Finished.";
echo -e "\0"

####

echo -e "Setting up Wordpress ..";

cd /tmp/
echo -e "[.   ] Ongoing"
wget -q https://fr.wordpress.org/wordpress-5.5.2-fr_FR.tar.gz
echo -en "[... ] Ongoing"
tar -xzf wordpress-5.5.2-fr_FR.tar.gz
mv wordpress/ /var/www/localhost/wordpress
mv /tmp/wp-config.php /var/www/localhost/wordpress/

echo -e "\0"
echo -e "Wordpress Setup Finished.";
echo -e "\0"

####

service php7.3-fpm start

####

echo -e "Setting up SSH ..";

mkdir ~/mkcert
cd ~/mkcert
echo -e "[.   ] Ongoing"
wget -q https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install >/dev/null 2>&1
echo  -en "[... ] Ongoing"
./mkcert localhost >/dev/null 2>&1
chmod -x mkcert

echo -e "\0"
echo -e "SSH Setup Finished.";
echo -e "\0"

####

cd /
chmod -w /tmp/autoindex/*

service nginx start

echo -e "\e[32m┌─────────────────────────────────────────────────────┐\e[0m";
echo -e "\e[32m│\e[0m                    \e[1mGOOD TO GO !\e[0m                     \e[32m│\e[0m";
echo -e "\e[32m└─────────────────────────────────────────────────────┘\e[0m";

bash
