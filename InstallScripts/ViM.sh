#!/bin/bash

PACKAGE_NAME="ViM"

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

################################# Custom Block #################################

CWD=$(pwd)
cd /tmp
wget https://aur.archlinux.org/packages/vi/vim-full/vim-full.tar.gz
tar -xvzf vim-full.tar.gz
cd vim-full
makepkg -si
cd "${CWD}"

################################################################################

############################## File Block ######################################

_CONF_NAME=vimrc
_CONF_FILE=${UHOME}/.${_CONF_NAME}
_BCK_FILE=${_CONF_FILE}.bck
_LOC_FILE=$(pwd)/${PACKAGE_NAME}/${_CONF_NAME}

echo "Checking if ${_CONF_FILE} exists"
if [ -f "${_CONF_FILE}" ]
then
    echo "File found, saving to ${_BCK_FILE}"
    mv "${_CONF_FILE}" "${_BCK_FILE}"
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_FILE}"
ln -s "${_LOC_FILE}" "${_CONF_FILE}"

################################################################################

################################ Dir Block #####################################

_DIR_NAME=vim
_CONF_DIR=${UHOME}/.${_DIR_NAME}
_BCK_DIR=${_CONF_DIR}bck
_LOC_DIR=$(pwd)/${PACKAGE_NAME}/${_DIR_NAME}

echo "Checking if ${_CONF_DIR} exists"
if [ -d "${_CONF_DIR}" ]
then
    echo "Directory found, saving to ${_BCK_DIR}"
    mv "${_CONF_DIR}" "${_BCK_DIR}"
fi

echo "Linking dotfile ${_CONF_NAME} to ${_CONF_DIR}"
ln -s "${_LOC_DIR}" "${_CONF_DIR}"

################################################################################

########################## Custom Commands #####################################

echo "Now installing Vundle"

mkdir "${_CONF_DIR}"/bundle
git clone https://github.com/gmarik/vundle.git "${_CONF_DIR}"/bundle/vundle

echo "Vundle Installed. Installing plguins..."
sleep 2
vim +PluginInstall +qall

# Install YCM
bash ViM/YCM.sh

echo "Downloading thesaurus..."
OCD=${PWD}
cd /tmp
wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
unzip mthes10.zip
mkdir ~/.vim/thesaurus
mv mthesaur.txt ~/.vim/thesaurus/mthesaur.txt
cd "$OCD"


if (which pacman)
then
    # We are in Arch Linux
    echo "Installing par from AUR"
    OCD=$(pwd)
    cd /tmp
    wget https://aur.archlinux.org/packages/pa/par/par.tar.gz
    tar -xvzf par.tar.gz
    cd par
    makepkg -si
    cd "$OCD"
fi

#echo "Please apply the patch available in ViM/ manually to the ctags.vim plugin."

################################################################################
