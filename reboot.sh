#!/bin/bash

## include other source
cd `dirname $0`
. ./common.sh
. ./session.sh

if [ "$#" -lt 1 ]; then
  reason="undefined"
else
  reason=$1
fi
## oper = {poweroff,suspend,hibernate,reboot}
if [ "$#" -lt 2 ] || ! [[ "$2" =~ ^[a-z]+$ ]]; then
  oper="reboot"
else
  oper=$2
fi

pre_reboot
log_time
log_echo "\033[36mSystem will $oper ($reason)\033[m"
exec_cmd "systemctl $oper"
