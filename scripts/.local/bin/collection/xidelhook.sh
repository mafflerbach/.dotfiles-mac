#!/bin/bash
export DISPLAY=:0
# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 300 \
    'xset dpms force off' \
    'xset dpms force on' \
  `# Undim & lock after 5 more seconds` \
  --timer 5 \
    'bash /home/maren/dotfiles/i3/script/lock.sh' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 600 \
    'systemctl suspend' \
    '' 
