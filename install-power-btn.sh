#!/bin/bash

## include other source
cd `dirname $0`
. ./common.sh

PATH_INSTALL="/usr/local/share"
NAME_SERVICE="rebooter"
PATH_EVENT="/etc/acpi/events"

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

mkdir -p $PATH_EVENT $PATH_INSTALL/$NAME_SERVICE

if [ -e "$PATH_EVENT/power" ]; then
	mv $PATH_EVENT/power $PATH_EVENT/power.bak
fi

exec_cmd "$SUDO cp -pr ./power-btn.sh $PATH_INSTALL/$NAME_SERVICE"
exec_cmd "$SUDO cp -pr ./power $PATH_EVENT"
exec_cmd "$SUDO chkconfig acpid on"
exec_cmd "$SUDO systemctl restart acpid"
