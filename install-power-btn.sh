#!/bin/bash

## include other source
cd `dirname $0`
# . ./session.env
. ./common.sh
. ./kevt.env

NAME_EVENT="power"

log_time

ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

acpid -v || {
	install_cmd acpid
}

mkdir -p ${PATH_EVENT} ${PATH_INSTALL}/${NAME_SERVICE}

if [ -e "${PATH_EVENT}/${NAME_EVENT}.conf" ]; then
	mv ${PATH_EVENT}/${NAME_EVENT}.conf ${PATH_INSTALL}/${NAME_SERVICE}/${NAME_EVENT}.conf.bak
fi

exec_cmd "${SUDO} cp -pr ./${NAME_EVENT}-btn.sh ${PATH_INSTALL}/${NAME_SERVICE}"
exec_cmd "${SUDO} cp -pr ./${NAME_EVENT}.conf ${PATH_EVENT}"
exec_cmd "${SUDO} chkconfig acpid on"
exec_cmd "${SUDO} systemctl restart acpid"
