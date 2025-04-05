#!/bin/bash

## include other source
cd `dirname $0`
. ./kevt.env
. ./common.sh
. ./session.sh

if [ -e ${PATH_RUN2} ]; then
  log_time
  log_echo "\033[36mCD play button pressed, event $1\033[m"
  rm -rf ${PATH_RUN1} ${PATH_RUN2}
  user_logout
  ./reboot.sh "power & cdplay button pushed" poweroff
else
  if hostnamectl | grep Hardware | grep Dell; then
    path_brightness=/sys/class/backlight/dell_uart_backlight/brightness
  else
    path_brightness=/sys/class/backlight/acpi_video0/brightness
  fi
  # for i in `find /dev/pts/* | grep -v ptmx`; do echo `cat ${path_brightness}` > $i ;done
  echo $(( `cat ${path_brightness}` - 5 )) > ${path_brightness}
fi
