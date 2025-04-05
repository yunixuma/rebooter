# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    session.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2025/04/05 22:33:50 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Define functions

. ./rebooter.env

log_status() {
	exec_cmd "hostname"
	exec_cmd "w"
	exec_cmd "df -h"
	exec_cmd "free"
	exec_cmd "ps aux"
	exec_cmd "systemctl status"
	exec_cmd "ifconfig"
	exec_cmd "ethtool ${NW_IF}"
}

user_lock() {
	user=`who | grep -E "\(:0\)" | awk '{print $1}'`
	if [ "${user}" == "" ]; then
		return
	fi
	log_time
	log_echo "\033[33mLocking ${user}'s screen ($1)\033[m"
	exec_cmd "whoami"
	exec_cmd "DISPLAY=:0 sudo -E -u ${user} i3lock -c 000000"
}

user_logout() {
	user=`who | grep -E "\(:0\)" | awk '{print $1}'`
	if [ "${user}" == "" ]; then
		return
	fi
	log_time
	log_echo "\033[33m${user} will logout ($1)\033[m"
	exec_cmd "sudo -E -u ${user} gnome-session-quit --logout --force --no-prompt"
	exec_cmd "systemctl stop user@`id -u ${user}`"
}

repair_state() {
	# exec_cmd "modprobe ${NW_DRV}"
	# exec_cmd "systemctl restart ${NW_SVC}"
}

reset_dm() {
	log_time
	log_echo "\033[31mWindow manager will restart\033[m"
	user_logout
	repair_state
	exec_cmd "systemctl restart ${DM}"
}

pre_reboot() {
	log_status
	user_logout
}
