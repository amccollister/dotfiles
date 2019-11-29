#!/bin/bash

# Terminate all polybar instances
killall -q polybar

# Wait until all processes have shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done;

# Launch the example bar
echo "---" | tee -a /tmp/polybar.log
polybar example -r >> /tmp/polybar.log 2>&1 &

echo "Bars launched..."

