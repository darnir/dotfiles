#!/bin/bash

CONF_NAME="Conky Config"

echo "Working on ${CONF_NAME}"

_CONF_NAME=conkyrc
_CONF_FILE=${HOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/conky/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

_CONF_NAME=conky_weather.sh
_CONF_FILE=${HOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/conky/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

wget https://dl.dropboxusercontent.com/u/18576690/conky_weather_icons.tar.gz
tar -xvzf conky_weather_icons.tar.gz
mv conky-weather-icons/ ${HOME}/.conky-weather-icons
rm conky_weather_icons.tar.gz

wget https://dl.dropboxusercontent.com/u/18576690/OpenSans-Light.ttf
mkdir -p ${HOME}/.fonts
mv OpenSans-Light.ttf ${HOME}/.fonts/
fc-cache -v
