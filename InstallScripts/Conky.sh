#!/bin/bash

PACKAGE_NAME="Conky"

############################ Initialize Script #################################

INSTALLSCRIPTS="InstallScripts"
SYSCONFDIR="/etc"
UHOME=${HOME}


if [ ! -f ${INSTALLSCRIPTS}/${PACKAGE_NAME}.sh ]
then
    echo "This is a simple script without much idiot-proof logic"
    echo "Please run the script only from the top-dir of the repository"
    exit 1
fi


echo "Installing package ${PACKAGE_NAME}"

################################################################################

############################## File Block ######################################

_CONF_NAME=conkyrc
_CONF_FILE=${UHOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${PACKAGE_NAME}/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

################################################################################

############################## File Block ######################################

_CONF_NAME=conky_weather.sh
_CONF_FILE=${UHOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${PACKAGE_NAME}/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

################################################################################

############################# Custom Commands ##################################

cd /tmp
wget https://dl.dropboxusercontent.com/u/18576690/conky_weather_icons.tar.gz
tar -xzf conky_weather_icons.tar.gz
mv conky-weather-icons/ ${UHOME}/.conky-weather-icons

wget https://dl.dropboxusercontent.com/u/18576690/OpenSans-Light.ttf
mkdir -p ${HOME}/.fonts
mv OpenSans-Light.ttf ${HOME}/.fonts/
fc-cache -v

################################################################################
