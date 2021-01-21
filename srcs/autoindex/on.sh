# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    on.sh                                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Julian <Julian@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/21 09:55:43 by Julian            #+#    #+#              #
#    Updated: 2021/01/21 09:55:43 by Julian           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
#Simple script for autoindex automation

test=$(grep -c "autoindex on" /etc/nginx/sites-available/localhost)

if [[ $test == 1 ]]
then
	echo "Autoindex already on!"
else
	sed -i "s/autoindex off;/autoindex on;/g" /etc/nginx/sites-available/localhost
	echo "Autoindex has been turned on!"
	service nginx restart
fi

exit
