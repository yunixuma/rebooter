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

acpid -v || {
	install_cmd acpid
}

if [ -e "$PATH_ACPI/events/power" ]; then
	mv $PATH_ACPI/events/power $PATH_ACPI/events/power.bak
fi

exec_cmd "$SUDO cp -pr ./power-btn.sh /etc/acpi/"
exec_cmd "$SUDO cp -pr ./power /etc/acpi/events/"
exec_cmd "$SUDO chkconfig acpid on"
exec_cmd "$SUDO systemctl restart acpid"
