# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    session.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2025/02/22 20:06:18 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Define functions

log_status() {
	exec_cmd "hostname"
	exec_cmd "w"
	exec_cmd "df -h"
	exec_cmd "free"
	exec_cmd "ps aux"
	exec_cmd "systemctl status"
	exec_cmd "ifconfig"
}

user_logout() {
	USER=`who | grep ":0" | awk '{print $1}'`
	if [ "$USER" != "" ]; then
		log_time
		log_echo "\033[33m$USER will logout ($1)\033[m"
		exec_cmd "sudo -E -u $USER gnome-session-quit --logout --force --no-prompt"
	fi
}

pre_reboot() {
	log_status
	user_logout
}
