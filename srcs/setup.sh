echo -e "\e[44m______________________________________________________\e[0m";
echo -e "\e[44m___________________ STARTING SETUP ___________________\e[0m";
echo -e "\e[44m______________________________________________________\e[0m";
#!/bin/bash

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
echo -e "\e[42m________________ MYSQL Setup Finished ________________\e[0m";
echo -e "\0"

####

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

echo -e "\e[44m_______________ Setting up PHPMyAdmin ________________\e[0m";

mkdir /var/www/localhost/phpmyadmin
echo -e "[.   ] Ongoing."
wget -q https://files.phpmyadmin.net/phpMyAdmin/4.9.6/phpMyAdmin-4.9.6-all-languages.tar.gz
echo  -en "[... ] Ongoing."
tar -xf phpMyAdmin-4.9.6-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
rm phpMyAdmin-4.9.6-all-languages.tar.gz

echo -e "\0"
echo -e "\e[42m_____________ PHPMyAdmin Setup Finished ______________\e[0m";
echo -e "\0"

####

echo -e "\e[44m________________ Setting up Wordpress ________________\e[0m";

cd /tmp/
echo -e "[.   ] Ongoing."
wget -q https://fr.wordpress.org/wordpress-5.5.2-fr_FR.tar.gz
echo -en "[... ] Ongoing."
tar -xzf wordpress-5.5.2-fr_FR.tar.gz
mv wordpress/ /var/www/localhost/wordpress
mv /tmp/wp-config.php /var/www/localhost/wordpress/

echo -e "\0"
echo -e "\e[42m______________ Wordpress Setup Finished ______________\e[0m";
echo -e "\0"

####

service php7.3-fpm start

####

echo -e "\e[44m___________________ Setting up SSH ___________________\e[0m";

mkdir ~/mkcert
cd ~/mkcert
echo -e "[.   ] Ongoing. "
wget -q https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install >/dev/null 2>&1
echo  -en "[... ] Ongoing."
./mkcert localhost >/dev/null 2>&1
chmod -x mkcert

echo -e "\0"
echo -e "\e[42m_________________ SSH Setup Finished _________________\e[0m";
echo -e "\0"

####

cd /
chmod -w /tmp/autoindex/*

echo -e "\e[42m______________________________________________________\e[0m";
echo -e "\e[42m____________________ GOOD TO GO ! ____________________\e[0m";
echo -e "\e[42m______________________________________________________\e[0m";


service nginx start

bash
