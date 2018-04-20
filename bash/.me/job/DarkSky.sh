#!/usr/bin/env bash

if ! command -v JSON &> /dev/null; then
  me addm JSON
fi

DS_KEY="$(pass show DarkSky/key)"
DS_LOCATION="$(pass show DarkSky/location)"   # [latitude],[longitude]
DS_TIME="$(date -d '1 day' +%s)"
DS_EXCLUDE='flags,alert,hourly,minutely,currently'
DS_UNITS='si'
DS_FORECAST_API="https://api.darksky.net/forecast/${DS_KEY}/${DS_LOCATION},${DS_TIME}?exclude=${DS_EXCLUDE}&units=${DS_UNITS}"

#TW_NEWLINE="%0a"
TW_SID="$(pass show twilio/sid)"
TW_TOKEN="$(pass show twilio/token)"
TW_TO="$(pass show twilio/to)"
TW_FROM="$(pass show twilio/from)"
TW_API="https://api.twilio.com/2010-04-01/Accounts/${TW_SID}/Messages.json"

declare -A data
declare -a data_keys=(
  'summary'
  'time'
  'temperatureMin'
  'temperatureMinTime'
  'temperatureMax'
  'temperatureMaxTime'
  'windSpeed'
  'windBearing'
)

filter() {
  # plus character " to every key
  for (( i=0; i<${#data_keys[@]}; i++ )); do
    data_keys[i]=${data_keys[i]}\"
  done

  # string join
  # thx: https://stackoverflow.com/a/17841619
  local IFS='|'
  regex=${data_keys[*]}
  sed -rn "/${regex}/ p" $1
}

parse() {
  while read -r key value; do
    key=${key::-2}    # delete last two characters " and ]
    key=${key##*\"}   # delete the characters from begining unit the last "

    # test whether array contains some value
    # thx: https://stackoverflow.com/a/15394738
    # only when the data_keys contains the key, then we store it into data
    if [[ " ${data_keys[@]} " =~ " ${key} " ]]; then
      data[${key}]=${value}
    fi
  done
}

# enable 'lastpipe' option: the shell runs the last command of a pipeline not
# executed in the background in the current shell environment. (so we can modify
# the current script variable in the function 'parse')
shopt -s lastpipe
curl ${DS_FORECAST_API} | JSON -l | filter | parse

send_sms() {
  curl -X POST ${TW_API} \
    --data-urlencode "To=${TW_TO}" \
    --data-urlencode "From=${TW_FROM}" \
    -d "Body=$*" \
    -u ${TW_SID}:${TW_TOKEN}
}

# TODO: check data is not null
message="Tomorrow is ${data[summary]} The maximum temperature is \
${data[temperatureMax]} degrees Celsius and the minimum is \
${data[temperatureMin]}. The windspeed tomorrow is ${data[windSpeed]}km/h."

printf "%s\n" "${message}"
send_sms ${message}
