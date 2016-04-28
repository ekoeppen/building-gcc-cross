script_loc=`cd $(dirname $0) && pwd -P`

. $script_loc/common.sh

PATH=$PREFIX/bin:$PATH

$NEWLIB_PATH/configure                          \
 --build=x86_64-apple-darwin15                  \
 --target=arm-eabi                              \
 --prefix=$PREFIX                               \
 --enable-newlib-io-long-long                   \
 --enable-newlib-register-fini                  \
 --disable-nls                                  \
 --disable-newlib-supplied-syscalls

make CFLAGS_FOR_TARGET='-g -O2 -ffunction-sections -fdata-sections' -w -j2 all

make -w install
