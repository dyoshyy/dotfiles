#!/bin/bash

TEMP=$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+')

if [[ -z "$TEMP" || "$TEMP" -ge 6000 ]]; then
  printf '{"text":"󰖙","tooltip":"Daylight (%sK)\\nClick to enable nightlight","class":"off"}\n' "${TEMP:-N/A}"
else
  printf '{"text":"󰖔","tooltip":"Nightlight (%sK)\\nClick to disable","class":"on"}\n' "$TEMP"
fi
