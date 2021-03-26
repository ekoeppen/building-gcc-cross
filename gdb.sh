#!/bin/bash

script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$PREFIX/bin:$PATH

$GDB_PATH/configure                             \
 --build=${BUILD}                               \
 --target=${TARGET}                             \
 --prefix=${PREFIX}                             \
 --disable-werror

make -w all -j${NPROCS}

cd gdb
make install
