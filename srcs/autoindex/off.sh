#Simple script for autoindex automation

test=$(grep -c "autoindex off" /etc/nginx/sites-available/localhost)

if [[ $test == 1 ]]
then
	echo "Autoindex already off!"
else
	sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/localhost
	echo "Autoindex has been turned off!"
	service nginx restart
fi
