#!/bin/bash

# Terminate all polybar instances
killall -q polybar

# Wait until all processes have shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done;

# Launch polybar
echo "---" | tee -a /tmp/polybar.log
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar main -r >> /tmp/polybar_$m.log 2>&1 &
done

echo "Bars launched bars for all monitors"