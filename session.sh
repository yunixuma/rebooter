# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    session.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2025/02/24 17:58:44 by ykosaka          ###   ########.fr        #
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
	user=`who | grep ":0" | awk '{print $1}'`
	if [ "$user" == "" ]; then
		return
	# if [ $2 != "" ] && [ "$user" =~ "$2" ]; then
	if [ "$user" =~ "$2" ]; then
		exit 1
	log_time
	log_echo "\033[33m$user will logout ($1)\033[m"
	exec_cmd "sudo -E -u $user gnome-session-quit --logout --force --no-prompt"
}

pre_reboot() {
	log_status
	user_logout
}
