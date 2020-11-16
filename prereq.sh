#!/bin/bash

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  PACKAGE_INSTALLER="apt"
  PACKAGE_UPDATE_COMMAND="update"
  PACKAGE_INSTALL_COMMAND="install -y"
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
  if command -v apt-cyg >/dev/null 2>&1; then
    echo apt-cyg already installed
  else
    echo installing apt-cyg
    lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
    install apt-cyg /bin
    rm ./apt-cyg
  fi
  PACKAGE_INSTALLER="apt-cyg"
  PACKAGE_UPDATE_COMMAND="update"
  PACKAGE_INSTALL_COMMAND="install"
fi

# update package tool
$PACKAGE_INSTALLER $PACKAGE_UPDATE_COMMAND

# get stuff that should always be available without conflicts
TO_INSTALL+='wget curl git subversion '

# get c++ compiler and tools
TO_INSTALL+='make cmake '
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  TO_INSTALL+='gcc g++ '
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
  TO_INSTALL+='gcc-core gcc-g++ '
fi

# get python interpreter, tools and libs
TO_INSTALL+='python3 '
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  TO_INSTALL+='python3-pip python3-dev '
fi

# install packages through manager
$PACKAGE_INSTALLER $PACKAGE_INSTALL_COMMAND $TO_INSTALL

# post-install stuff
if [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
  python3 -m ensurepip
fi
pip3 install --upgrade pip
