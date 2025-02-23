#!/bin/bash

DM=lightdm
DURATION=10
PATH_RUN1="/tmp/pre_rebootme"
PATH_RUN2="/tmp/rebootme"

## include other source
cd `dirname $0`
. ./common.sh
. ./session.sh

if [ -e $PATH_RUN2 ]; then
  log_time
  log_echo "\033[36mPower button pressed three times, event $1\033[m"
  rm -rf $PATH_RUN1 $PATH_RUN2
  ./reboot.sh "power button pushed"
elif [ -e $PATH_RUN1 ]; then
  log_time
  log_echo "\033[33mPower button pressed twice, event $1\033[m"
  log_time
  log_echo "\033[31mWindow manager will restart\033[m"
  mv $PATH_RUN1 $PATH_RUN2
  log_Status
  user_logout
  exec_cmd "systemctl restart $DM"
else
  log_time
  log_echo "\033[36mPower button pressed three times, event $1\033[m"
  echo $(date +"%Y-%m-%d %H:%M:%S") > $PATH_RUN1
fi

sleep $DURATION
if [ -e $PATH_RUN1 ] || [ -e $PATH_RUN2 ]; then
  log_time
  log_echo "\033[35mReboot canceled\033[m"
  rm -f $PATH_RUN1 $PATH_RUN2
fi
