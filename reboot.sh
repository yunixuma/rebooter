#!/bin/bash

## include other source
cd `dirname $0`
. ./rebooter.env
. ./common.sh
. ./session.sh

if [ "$#" -lt 1 ]; then
  reason="undefined"
else
  reason=$1
fi
## oper = {poweroff,halt,reboot,hibernate,suspend,hybrid-sleep}
if [ "$#" -lt 2 ] || ! [[ "$2" =~ ^[a-z]+$ ]]; then
  oper="reboot"
else
  oper=$2
fi

if [ "$#" -ge 3 ]; then
  user=`who | grep -E "\(:0\)" | awk '{print $1}'`
  if [ "${user}" != "" ] && [[ ${user} =~ $3 ]]; then
    exit 1
  fi
fi
## user=`who | grep -E "\(:0\)" | awk '{print $1}'`
## if [ "${user}" != "" ] && [[ ${user} =~ ${user_except} ]]; then
## 	exit 1
## fi

pre_reboot ${reason}
log_time
log_echo "\033[36mSystem will ${oper} (${reason})\033[m"
exec_cmd "systemctl ${oper}"
