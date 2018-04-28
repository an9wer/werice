#!/usr/bin/env bash

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
  'sunriseTime'
  'sunsetTime'
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

wind_bearing() {
  if [ $1 == 0 ]; then
    data[windBearing]=正北
  elif [ $1 -gt 0 -a $1 -lt 90 ]; then
    data[windBearing]=东北
  elif [ $1 == 90 ]; then
    data[windBearing]=正东
  elif [ $1 -gt 90 -a $1 -lt 180 ]; then
    data[windBearing]=东南
  elif [ $1 == 180 ]; then
    data[windBearing]=正南
  elif [ $1 -gt 180 -a $1 -lt 270 ]; then
    data[windBearing]=西南
  elif [ $1 == 270 ]; then
    data[windBearing]=正西
  elif [ $1 -gt 270 -a $1 -lt 360 ]; then
    data[windBearing]=西北
  elif [ $1 == 360 ]; then
    data[windBearing]=正北
  else
    data[windBearing]=""
  fi
}

generate_message() {
  day="${1} day"
  DS_TIME=$(date -d "${day}" +%s)

  # need: DS_KEY, DS_LOCATION, DS_TIME, DS_EXCLUDE, DS_UNITS, DS_LANG
  DS_FORECAST_API="https://api.darksky.net/forecast/${DS_KEY}/${DS_LOCATION},${DS_TIME}"
  DS_FORECAST_API+="?exclude=${DS_EXCLUDE}&units=${DS_UNITS}"
  [[ -n "${DS_LANG}" ]] && DS_FORECAST_API+="&lang=${DS_LANG}"

  # enable 'lastpipe' option: the shell runs the last command of a pipeline not
  # executed in the background in the current shell environment. (so we can modify
  # the current script variable in the function 'parse')
  shopt -s lastpipe
  curl -s ${DS_FORECAST_API} | JSON -l | filter | parse
  shopt -u lastpipe

  # TODO: check data is not null
  if [[ -n "${data[summary]}" ]]; then
    en_message+=$(date -d @${data[time]} +%m-%d)
    en_message+=": ${data[summary]} "
    en_message+="temperatureMax: ${data[temperatureMax]}°C. "
    #en_message+="temperatureMaxTime: $(date -d @${data[temperatureMaxTime]} +'%H:%M'). "
    en_message+="temperatureMin: ${data[temperatureMin]}°C. "
    #en_message+="temperatureMinTime: $(date -d @${data[temperatureMinTime]} +'%H:%M'). "
    en_message+="windSpeed: ${data[windSpeed]}km/h. "
    en_message+="windBearing: ${data[windBearing]}°. "
    en_message+="sunriseTime: $(date -d @${data[sunriseTime]} +'%H:%M'). "
    en_message+="sunsetTime: $(date -d @${data[sunsetTime]} +'%H:%M'). "

    zh_message+=$(date -d "${day}" +%m-%d)
    zh_message+=" 天气: ${data[summary]} "
    zh_message+="最高气温 ${data[temperatureMax]}°C ，"
    #zh_message+="出现在 $(date -d @${data[temperatureMaxTime]} +'%H:%M')。"
    zh_message+="最低气温 ${data[temperatureMin]}°C ，"
    #zh_message+="出现在 $(date -d @${data[temperatureMinTime]} +'%H:%M')。"
    zh_message+="日出 $(date -d @${data[sunriseTime]} +'%H:%M')，"
    zh_message+="日落 $(date -d @${data[sunsetTime]} +'%H:%M')。"
    wind_bearing ${data[windBearing]}
    if [[ -n ${data[windBearing]} ]]; then
      zh_message+="${data[windBearing]}风，风速 ${data[windSpeed]}km/h。"
    else
      zh_message+="风速 ${data[windSpeed]}km/h。"
    fi
  fi
}

send_sms() {
  # need: TW_SID, TW_TOKEN, TW_TO, TW_FROM, TW_API
  TW_API="https://api.twilio.com/2010-04-01/Accounts/${TW_SID}/Messages.json"

  curl -X POST ${TW_API} \
    --data-urlencode "To=${TW_TO}" \
    --data-urlencode "From=${TW_FROM}" \
    -d "Body=$*" \
    -u ${TW_SID}:${TW_TOKEN}
}


# read variable from config file
[[ -e /tmp/DarkSky.conf ]] && . /tmp/DarkSky.conf || . ${ME_JOB_DARKSKY_DIR}/DarkSky.conf

while getopts "cd:l:t:a:" opt; do
  case ${opt} in
    c)  # create temporary config file
      TMP_CONF=/tmp/DarkSky.conf
      cp -f ${ME_JOB_DARKSKY_DIR}/DarkSky.conf ${TMP_CONF}

      shopt -s lastpipe
      # remove comments and then loop every line
      for line in $(sed 's/#.*//' ${TMP_CONF}); do
        echo ${line} | awk -F '=' '{print $1, $2}' | read -r key val
        [[ -n "${val}" ]] && printf "%s (default %s): " "${key}" "${val}" || printf "%s: " ${key}

        read input
        if [ -n "${input}" -o -z "${val}" ]; then
          sed -ri "s/(${key}=).*/\1\"${input}\"/" ${TMP_CONF}
        fi
      done
      shopt -u lastpipe
      me prompt "all is done :)"
      exit 0
      ;;

    d)  # days
      if ! (( ${OPTARG} >= 1 && ${OPTARG} <= 7 )); then
        me warn "the argument of option 'days' must be from 1 to 7."
        exit 1
      fi
      days=${OPTARG}
      ;;

    l)  # location
      # TODO: add restriction
      DS_LOCATION=${OPTARG}   # [latitude],[longitude]
      ;;

    a)  # language
      DS_LANG=${OPTARG}
      ;;

    t)  # sms to
      TW_TO=${OPTARG}
      ;;
  esac

done

for (( i=1; i<=${days}; i++ )); do
  generate_message ${i}
done

if [[ ${DS_LANG} == zh ]]; then
  printf "$(date): %s\n" "${zh_message}"
  #send_sms ${zh_message}
else
  printf "$(date): %s\n" "${en_message}"
  #send_sms ${en_message}
fi
