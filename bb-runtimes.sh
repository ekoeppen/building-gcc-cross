#!/bin/sh

if [ ${TARGET} != "arm-eabi" ]; then
    echo "Skipping build for non-arm target ${TARGET}"
fi

rm -rf install

prefix=$1; shift
gcc_dir=$1; shift
gnat_dir=$1; shift

./gen_rts_sources.py --gcc-dir "${gcc_dir}" --gnat-dir "${gnat_dir}" --rts-profile ravenscar-sfp

for target in $@
do
    ./build_rts.py  --rts-src-descriptor ./install/lib/gnat/rts-sources.json "${target}"
    for rts in zfp ravenscar-sfp
    do
        if [ ! -d install/"${rts}-${target}" ]; then continue; fi
        cd install/"${rts}-${target}"
        gprbuild -q -p -P runtime_build.gpr
        mkdir -p "${prefix}/rts-${rts}-${target}"
        cp -R adalib "${prefix}/rts-${rts}-${target}/"
        cp -R gnat "${prefix}/rts-${rts}-${target}/adainclude"
        cd ../..
    done
done
