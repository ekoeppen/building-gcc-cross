ARG registry

FROM ${registry}gnat-cross-src:community-2020 as build

ARG target=arm-eabi
ENV TARGET=$target

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash curl gzip patch git \
    libc-dev make texinfo gnat-10 g++ zlib1g-dev python3 flex bison
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && \
    ln -s /usr/lib/gcc/x86_64-linux-gnu/10 /usr/lib/gcc/x86_64-linux-gnu/10.2.0

WORKDIR /build

ENV SRC_PATH=/build
ENV PREFIX=/usr/local

RUN tar xf gprbuild-2020-20200429-19BD2-src.tar.gz && \
    tar xf xmlada-2020-20200429-19A99-src.tar.gz
RUN cd /build/gprbuild-2020-20200429-19BD2-src && bash ./bootstrap.sh --with-xmlada=../xmlada-2020-20200429-19A99-src && \
    cd /build/xmlada-2020-20200429-19A99-src && ./configure --prefix=/usr/local && \
    make && make install && \
    cd /build/gprbuild-2020-20200429-19BD2-src && export GPR_PROJECT_PATH=/usr/local/share/gpr && \
    make prefix=/usr/local setup && make all && make install
COPY patches/compilers-user-rt.xml /usr/local/share/gprconfig/

COPY binutils.sh gcc.sh common.sh patches/gcc-remove-jorvik.patch /build/
RUN mkdir gcc gcc-boot binutils && \
    tar xf gcc-9-2020-20200429-19AA7-src.tar.gz && \
    tar xf gnat-2020-20200429-19B04-src.tar.gz && \
    tar xf gcc-interface-9-2020-20200429-19B10-src.tar.gz && \
    tar xf binutils-2.34.tar.gz && \
    cd /build/gcc-9-2020-20200429-19AA7-src/ && ./contrib/download_prerequisites && \
    cd /build && \
    mv gnat-2020-20200429-19B04-src/src/ada gcc-9-2020-20200429-19AA7-src/gcc/ada && \
    mv gcc-interface-9-2020-20200429-19B10-src gcc-9-2020-20200429-19AA7-src/gcc/ada/gcc-interface && \
    patch -p0 < gcc-remove-jorvik.patch

RUN cd /build/binutils && ../binutils.sh
RUN cd /build/gcc && ../gcc.sh

COPY newlib.sh ./
RUN cd /build && mkdir newlib && tar xf newlib-3.3.0.tar.gz
RUN cd /build/newlib && ../newlib.sh

COPY bb-runtimes.sh ./
RUN rm -rf bb-runtimes && git clone --depth 1 --branch community-2020 https://github.com/ekoeppen/bb-runtimes.git
RUN cd /build/bb-runtimes && \
    ../bb-runtimes.sh /usr/local/arm-eabi/lib/gnat /build/gcc-9-2020-20200429-19AA7-src/ /build/gcc-9-2020-20200429-19AA7-src/gcc/ada/ \
        cortex-m0 cortex-m3 cortex-m4 cortex-m4f \
        stm32f030f4-hsi stm32f070f6-hsi stm32f051k8-hsi stm32f072rb-hsi nucleo_f401re \
        microbit min-stm32f103

FROM ubuntu:20.04

COPY --from=build /usr/local /usr/local
COPY --from=build /build/gcc-9-2020-20200429-19AA7-src/gcc/ada/ /usr/local/include/rts-sources/
COPY --from=build /build/gcc-9-2020-20200429-19AA7-src/libgcc/unwind*.h /usr/local/include/gcc/
WORKDIR /build
