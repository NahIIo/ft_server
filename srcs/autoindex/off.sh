# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    off.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Julian <Julian@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/21 09:55:37 by Julian            #+#    #+#              #
#    Updated: 2021/01/21 09:55:46 by Julian           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
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

exit
