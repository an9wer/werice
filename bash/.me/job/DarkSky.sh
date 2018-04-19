#!/usr/bin/env bash

if ! command -v JSON &> /dev/null; then
  me addm JSON
fi

DS_KEY="$(pass show DarkSky/key)"
DS_LOCATION="$(pass show DarkSky/location)"
DS_EXCLUDE='flags,alert,hourly,minutely,currently'
DS_UNITS='si'
DS_FORECAST_API="https://api.darksky.net/forecast/${DS_KEY}/${DS_LOCATION}?exclude=${DS_EXCLUDE}&units=${DS_UNITS}"

curl ${DS_FORECAST_API} | JSON -l
