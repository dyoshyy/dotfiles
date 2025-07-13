#!/bin/bash

# wttr.in - シンプルな天気API（登録不要）
CITY="Sapporo"

# wttr.inから現在の天気データを取得
WEATHER_DATA=$(curl -s "https://wttr.in/${CITY}?format=j1")

# エラーチェック
if [[ -z "$WEATHER_DATA" ]]; then
    echo '{"icon":"❌", "temp":"--", "desc":"API Error"}'
    exit 1
fi

# データ抽出 - 現在の気温
TEMP_C=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].temp_C // "--"')
FEELS_LIKE=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].FeelsLikeC // "--"')
WEATHER_DESC=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherDesc[0].value // "Unknown"')
WEATHER_CODE=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherCode // "999"')

# 体感温度との差が大きい場合は表示に含める
if [[ "$FEELS_LIKE" != "--" ]] && [[ "$TEMP_C" != "--" ]]; then
    TEMP_DIFF=$((FEELS_LIKE - TEMP_C))
    if [[ $TEMP_DIFF -gt 3 ]] || [[ $TEMP_DIFF -lt -3 ]]; then
        TEMP_DISPLAY="${TEMP_C}°(体感${FEELS_LIKE}°)"
    else
        TEMP_DISPLAY="${TEMP_C}°"
    fi
else
    TEMP_DISPLAY="${TEMP_C}°"
fi

# 天気コードからアイコンを決定
ICON="?"
case $WEATHER_CODE in
"113") ICON="☀️" ;;                                                                                  # Sunny
"116") ICON="🌤️" ;;                                                                                  # Partly cloudy
"119") ICON="☁️" ;;                                                                                  # Cloudy
"122") ICON="☁️" ;;                                                                                  # Overcast
"143" | "248" | "260") ICON="🌫️" ;;                                                                  # Fog
"176" | "263" | "266" | "293" | "296" | "299" | "302" | "305" | "308" | "353") ICON="🌧️" ;;          # Light rain
"179" | "182" | "185" | "281" | "284" | "311" | "314" | "317" | "320" | "323" | "326") ICON="��️" ;; # Rain shower
"227" | "230" | "323" | "326" | "329" | "332" | "335" | "338" | "368" | "371") ICON="❄️" ;;          # Snow
"200" | "386" | "389" | "392" | "395") ICON="⛈️" ;;                                                  # Thunderstorm
*) ICON="❓" ;;
esac

# QuickShell用JSON出力
echo "{\"icon\":\"$ICON\", \"temp\":\"$TEMP_DISPLAY\", \"desc\":\"$WEATHER_DESC\"}"
