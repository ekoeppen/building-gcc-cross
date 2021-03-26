#!/bin/bash

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

$BINUTILS_PATH/configure                        \
 --target=${TARGET}                             \
 --prefix=${PREFIX}                             \
 --disable-nls                                  \
 --disable-werror                               \
 --enable-interwork

make -w -j${NPROC}

make install
