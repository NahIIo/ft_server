# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    autoindex.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Julian <Julian@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/21 09:55:43 by Julian            #+#    #+#              #
#    Updated: 2021/01/26 16:01:32 by Julian           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
#Simple script for autoindex automation
echo "Please enter what mode you want autoindex to be on: On/Off"

read result
pos='On'
neg='Off'
if [[ $result == $pos ]]
then

	test=$(grep -c "autoindex on" /etc/nginx/sites-available/localhost)

	if [[ $test == 1 ]]
	then
		echo "Autoindex already on!"
	else
		sed -i "s/autoindex off;/autoindex on;/g" /etc/nginx/sites-available/localhost
		echo "Autoindex has been turned on!"
		service nginx restart
	fi
elif [[ $result == $neg ]]
then
	test=$(grep -c "autoindex off" /etc/nginx/sites-available/localhost)

	if [[ $test == 1 ]]
	then
		echo "Autoindex already off!"
	else
		sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/localhost
		echo "Autoindex has been turned off!"
		service nginx restart
	fi
else

	echo "Invalid Input!"

fi
exit
