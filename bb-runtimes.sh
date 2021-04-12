#!/bin/sh

if [ "${TARGET}" != "arm-eabi" ]; then
    echo "Skipping build for non-arm target ${TARGET}"
    exit
fi

rm -rf install

prefix=$1; shift
gcc_dir=$1; shift
gnat_dir=$1; shift

./gen_rts_sources.py --gcc-dir "${gcc_dir}" --gnat-dir "${gnat_dir}" --rts-profile ravenscar-full

for target in $@
do
    ./build_rts.py --output ${prefix} --build --rts-src-descriptor ./install/lib/gnat/rts-sources.json "${target}"
done
