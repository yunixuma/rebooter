#!/bin/bash

## include other source
cd `dirname $0`
. ./common.sh

PATH_ACPI="/etc/acpi"

log_time

ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

exec_cmd "$SUDO rm $PATH_ACPI/power-btn.sh"
exec_cmd "$SUDO rm $PATH_ACPI/events/power"
if [ -e "$PATH_ACPI/events/power.bak" ]; then
	mv $PATH_ACPI/events/power.bak $PATH_ACPI/events/power
fi
exec_cmd "$SUDO systemctl restart acpid"
