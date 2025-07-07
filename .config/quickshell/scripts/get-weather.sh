#!/bin/bash

# wttr.inから札幌の天気をJSON形式で取得
WEATHER_DATA=$(curl -s "https://wttr.in/Sapporo?format=j1")

# JSONデータから現在の天気の状況と気温を抽出
# jqコマンドが必要になります
CURRENT_CONDITION=$(echo $WEATHER_DATA | jq -r '.current_condition[0]')
TEMP_C=$(echo $CURRENT_CONDITION | jq -r '.temp_C')
WEATHER_DESC=$(echo $CURRENT_CONDITION | jq -r '.weatherDesc[0].value')

# 天気コードからアイコンを決定する
WEATHER_CODE=$(echo $CURRENT_CONDITION | jq -r '.weatherCode')

ICON="?"
case $WEATHER_CODE in
"113") ICON="☀️" ;; # Sunny
"116") ICON="⛅" ;;  # Partly cloudy
"119") ICON="☁️" ;; # Cloudy
"122") ICON="☁️" ;; # Overcast
"266") ICON="🌧️" ;; # Light drizzle
"296") ICON="🌧️" ;; # Light rain
"302") ICON="🌧️" ;; # Moderate rain
"353") ICON="🌧️" ;; # Light rain shower
*) ICON="?" ;;
esac

# ewwが読み取れるJSON形式で出力
echo "{\"icon\":\"$ICON\", \"temp\":\"$TEMP_C\", \"desc\":\"$WEATHER_DESC\"}"
