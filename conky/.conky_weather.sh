#!/bin/bash

MUMID=2295411
HYDID=2295414
KLID=664474
WOEID=${KLID}

curl -s "http://weather.yahooapis.com/forecastrss?w=${WOEID}&u=c" -o ~/.cache/weather.xml.tmp
grep -q '<rss version="2.0" xmlns:yweather="http://xml.weather.yahoo.com/ns/rss/1.0" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#">' ~/.cache/weather.xml.tmp
if [ $? -eq 0 ]
then
    mv ~/.cache/weather.xml.tmp ~/.cache/weather.xml
fi
