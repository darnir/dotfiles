#!/bin/bash

COMPTON_CONF=${HOME}/.compton.conf
COMPTON_BCK=${COMPTON_CONF}.bck

if [ -f ${COMPTON_CONF} ]
then
    mv ${COMPTON_CONF} ${COMPTON_BCK}
fi

ln -s $(pwd)/compton.conf ${COMPTON_CONF}
