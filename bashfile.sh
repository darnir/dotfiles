#!/bin/bash

CONF_NAME="Bash Config"

echo "Working on ${CONF_NAME}"

_CONF_NAME=bashrc
_CONF_FILE=${HOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

_CONF_NAME=bash_profile
_CONF_FILE=${HOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}

_CONF_NAME=bash_aliases
_CONF_FILE=${HOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f ${_CONF_FILE} ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv ${_CONF_FILE} ${_BCK_FILE}
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s ${_LOC_FILE} ${_CONF_FILE}
