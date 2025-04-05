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

if [ "$#" -ge 2 ]; then
  user=`who | grep -E "\(:0\)" | awk '{print $1}'`
  if [ "${user}" != "" ] && [[ ${user} =~ $2 ]]; then
    exit 1
  fi
fi

log_time
log_echo "\033[36mSystem will logout (${reason})\033[m"
reset_dm
