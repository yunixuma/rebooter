#!/bin/bash

## include other source
cd `dirname $0`
. ./common.sh

PATH_INSTALL="/usr/local/share"
NAME_SERVICE="rebooter"
PATH_EVENT="/etc/acpi/events"
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

exec_cmd "${SUDO} rm ${PATH_INSTALL}/${NAME_SERVICE}/${NAME_EVENT}-btn.sh"
exec_cmd "${SUDO} rm ${PATH_EVENT}/${NAME_EVENT}"
if [ -e "${PATH_EVENT}/${NAME_EVENT}.bak" ]; then
	mv ${PATH_EVENT}/${NAME_EVENT}.bak ${PATH_EVENT}/${NAME_EVENT}
fi
exec_cmd "${SUDO} systemctl restart acpid"
