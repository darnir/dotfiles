#!/bin/bash

PACKAGE_NAME="ArchLinux"

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

_CONF_NAME=pacman.conf
_CONF_FILE=${SYSCONFDIR}/${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${PACKAGE_NAME}/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f "${_CONF_FILE}" ]
then
    echo "File found, saving to ${_BCK_FILE}"
    sudo mv "${_CONF_FILE}" "${_BCK_FILE}"
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
sudo ln -s "${_LOC_FILE}" "${_CONF_FILE}"

################################################################################

############################## Directory Block #################################

_CONF_NAME=vim
_CONF_DIR=${UHOME}/.${_CONF_NAME}
_BCK_DIR=${_CONF_DIR}bck
_LOC_DIR=$(pwd)/${PACKAGE_NAME}/${_CONF_NAME}

echo "Checking if ${_CONF_DIR} exists"
if [ -d "${_CONF_DIR}" ]
then
    echo "Directory found, saving to ${_BCK_DIR}"
    sudo mv "${_CONF_DIR}" "${_BCK_DIR}"
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_DIR}"
sudo ln -s "${_LOC_DIR}" "${_CONF_DIR}"

################################################################################
