# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    common.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2025/03/18 09:13:18 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FILE_LOG=${PATH_LOG}/${NAME_SERVICE}/`basename $0 .sh`.log

## Define functions
log_echo() {
	# echo -e "$@" | tee -a ${FILE_LOG}
	echo -e "$@" >> ${FILE_LOG}
}

log_time() {
	echo '[$(date +"%Y-%m-%d %H:%M:%S")]	' | tee -a ${FILE_LOG}
	echo '[$(date +"%Y-%m-%d %H:%M:%S")]	' >> ${FILE_LOG}
}

exec_cmd() {
	CMD=$1
	log_time
	log_echo "\033[32m> \033[1m${CMD}\033[m"
	# ${CMD} 2>&1 | tee -a ${FILE_LOG}
	# ${CMD} > >(tee -a ${FILE_LOG} >&1 ) 2> >(tee -a ${FILE_LOG} >&2)
	${CMD} 2>&1 >> ${FILE_LOG}
}

install_cmd() {
    CMD="$@"
	exec_cmd "${SUDO} apt-get install -y ${CMD}"
}
