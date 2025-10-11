#!/bin/sh
# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/hack"
MONITOR="DP-0"
TIMEOUT=10
elapsed=0

while ! xrandr | grep -q "^$MONITOR connected"; do
  sleep 0.1
  elapsed=$((elapsed + 1))
  if [ "$elapsed" -ge "$((TIMEOUT * 10))" ]; then
    echo "Timeout waiting for $MONITOR"
    break
  fi
done

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

sleep 1 # *strategic sleep*

# Launch the bar
# polybar -r -q top -c "$DIR"/config.ini &
polybar -r -q bottom -c "$DIR"/config.ini &

