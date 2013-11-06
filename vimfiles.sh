#!/bin/bash

VIMRC_ORIG=${HOME}/.vimrc
VIMRC_BCK=${VIMRC_ORGIG}.bck
VIMCONF=${HOME}/.vim
VIMCONF_BCK=${VIMCONF}bck

if [ -f ${VIMRC_ORIG} ]
then
    mv ${VIMRC_ORIG} ${VIMRC_BCK}
fi

if [ -d ${VIMCONF} ]
then
    mv ${VIMCONF} ${VIMCONF_BCK}
fi

ln -s $(pwd)/vimrc ${VIMRC_ORIG}
ln -s $(pwd)/vim ${VIMCONF}
