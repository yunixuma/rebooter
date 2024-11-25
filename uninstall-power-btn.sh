#!/bin/bash
PATH_LOG=./`basename $0 .sh`.log

## include other source
cd `dirname $0`
. ./install-common.sh

log_time

ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

exec_cmd "$SUDO rm /etc/acpi/power-btn.sh"
exec_cmd "$SUDO rm /etc/acpi/events/power"
if [ -e "/etc/acpi/events/power.bak" ]; then
	mv /etc/acpi/events/power.bak /etc/acpi/events/power
fi
exec_cmd "$SUDO service acpid restart"
