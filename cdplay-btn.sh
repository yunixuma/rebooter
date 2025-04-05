#!/bin/bash

## include other source
cd `dirname $0`
. ./kevt.env
. ./common.sh
. ./session.sh

STEP_SMALL=10
STEP_LARGE=25
LEVEL_DIM=${STEP_SMALL}
LEVEL_MAX=85

if [ -e ${PATH_RUN2} ]; then
  log_time
  log_echo "\033[36mCD play button pressed, event $1\033[m"
  rm -rf ${PATH_RUN1} ${PATH_RUN2}
  user_lock
  # log_status
  # repair_state
else
  if hostnamectl | grep Hardware | grep Dell; then
    path_brightness=/sys/class/backlight/dell_uart_backlight/brightness
  else
    path_brightness=/sys/class/backlight/acpi_video0/brightness
  fi
  # for i in `find /dev/pts/* | grep -v ptmx`; do echo `cat ${path_brightness}` > $i ;done
  level_current=`cat ${path_brightness}`
  if [ ${level_current} -lt ${LEVEL_DIM} ]; then
    echo $(( ${level_current} + ${STEP_SMALL} )) > ${path_brightness}
  elif [ $(( ${level_current} + ${STEP_LARGE} )) -lt ${LEVEL_MAX} ]; then
    echo "$(( ${level_current} + ${STEP_LARGE} ))" > ${path_brightness}
  elif [ ${level_current} -eq ${LEVEL_MAX} ]; then
    echo 0 > ${path_brightness}
  else
    echo ${LEVEL_MAX} > ${path_brightness}
  fi
fi
