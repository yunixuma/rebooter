#!/bin/bash

## include other source
cd `dirname $0`
. ./rebooter.env
. ./common.sh

log_time

ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

exec_cmd "$SUDO rm $PATH_INSTALL/$NAME_SERVICE/power-btn.sh"
exec_cmd "$SUDO rm $PATH_EVENT/power"
if [ -e "$PATH_EVENT/power.bak" ]; then
	mv $PATH_EVENT/power.bak $PATH_EVENT/power
fi
exec_cmd "$SUDO systemctl restart acpid"
