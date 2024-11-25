# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    session.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2024/11/25 22:22:26 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Define functions

user_logout() {
	USER=`who | grep ":0" | awk '{print $1}'`
	if [ "$USER" != "" ]; then
		log_time
		log_echo "\033[33m$USER will logout\033[m"
		exec_cmd "sudo -E -u $USER gnome-session-quit --logout --force --no-prompt"
	fi
}

