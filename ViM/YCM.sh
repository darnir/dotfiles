#!/bin/bash

CWD=$(pwd)
cd "${HOME}"
mkdir ycl_build
cd ycl_build
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
make
cd "${HOME}"
rm -r ycl_build
cd "$CWD"
