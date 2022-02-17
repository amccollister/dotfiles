#!/bin/bash

status=$(spt pb -f "%s")

if [[ ! -z "$status" && $status == '⏸' ]]; then
	echo PAUSED
elif [[ ! -z "$status" && $status == '▶' ]]; then
	echo $(spt pb -f "%t - %a")
else
	echo OFFLINE
fi
