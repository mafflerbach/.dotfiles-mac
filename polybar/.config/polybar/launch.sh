#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar &
    MONITOR=$m polybar --reload mybar2 &
    MONITOR=$m polybar --reload mybar3 &
    MONITOR=$m polybar --reload mybar4 &

  done
else
    polybar --reload mybar &
    polybar --reload mybar2 &
    polybar --reload mybar3 &
    polybar --reload mybar4 &
fi



echo "Polybar launched..."
