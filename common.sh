# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    common.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2024/11/25 22:20:10 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Define functions
log_echo() {
	echo -e "$@" | tee -a $PATH_LOG
}

log_time() {
	echo "[$(date +"%Y-%m-%d %H:%M:%S")]\t" | tee -a $PATH_LOG
}

exec_cmd() {
	CMD=$1
	log_time
	log_echo "\033[32m> \033[1m$CMD\033[m"
	$CMD 2>&1 | tee -a $PATH_LOG
	# $CMD > >(tee -a $PATH_LOG >&1 ) 2> >(tee -a $PATH_LOG >&2)
}

install_cmd() {
    CMD="$@"
	exec_cmd "$SUDO apt-get install -y $CMD"
}
