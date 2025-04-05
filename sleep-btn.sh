#!/bin/bash

## include other source
cd `dirname $0`
. ./kevt.env
. ./common.sh
. ./session.sh

if [ -e ${PATH_RUN2} ]; then
  log_time
  log_echo "\033[36mSleep button pressed twice, event $1\033[m"
  rm -rf ${PATH_RUN1} ${PATH_RUN2}
  log_status
  reset_dm
else
  log_time
  log_echo "\033[31mSleep button pressed once, event $1\033[m"
  user_lock
  echo $(date +"%Y-%m-%d %H:%M:%S") > ${PATH_RUN2} # > ${PATH_RUN1}
fi

sleep ${DURATION}
if [ -e ${PATH_RUN1} ] || [ -e ${PATH_RUN2} ]; then
  log_time
  log_echo "\033[35mSleep canceled\033[m"
  rm -f ${PATH_RUN1} ${PATH_RUN2}
fi
