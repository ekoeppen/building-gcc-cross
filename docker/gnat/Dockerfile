ARG registry

FROM ${registry}gnat-cross-src:10.2.0 as build

ARG target=arm-eabi
ENV TARGET=$target

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash curl gzip \
    libc-dev make texinfo gnat-10 g++ zlib1g-dev python3
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && \
    ln -s /usr/lib/gcc/x86_64-linux-gnu/10 /usr/lib/gcc/x86_64-linux-gnu/10.2.0

WORKDIR /build

RUN cd /build/gprbuild && ./bootstrap.sh --with-xmlada=../xmlada && \
    cd /build/xmlada && ./configure --prefix=/usr/local && \
    make && make install && \
    cd /build/gprbuild && export GPR_PROJECT_PATH=/usr/local/share/gpr && \
    make prefix=/usr/local setup && make all && make install

COPY binutils.sh gcc.sh common.sh ./
RUN mkdir gcc gcc-boot binutils && \
    tar xf gcc-10.2.0.tar.gz && \
    tar xf binutils-2.34.tar.gz && \
    cd gcc-10.2.0/ && ./contrib/download_prerequisites

RUN export SRC_PATH=/build && export CC=gcc-10 && export PREFIX=/usr/local && \
    cd /build/binutils && ../binutils.sh && \
    cd /build/gcc && ../gcc.sh

COPY newlib.sh ./
RUN cd /build && mkdir newlib && tar xf newlib-3.3.0.tar.gz
RUN export SRC_PATH=/build && export PREFIX=/usr/local && \
    cd /build/newlib && ../newlib.sh

COPY bb-runtimes.sh ./
RUN tar xf gnat-2020-20200429-19B04-src.tar.gz && \
    tar xf cortex-gnat-rts-r20201014.tar.gz && \
    tar xf componolit-ada-runtime-1.2.0.tar.gz
RUN cd /build/bb-runtimes && \
    ../bb-runtimes.sh /usr/local/lib/gcc/arm-eabi/10.2.0/ /build/gcc /build/gnat-2020-20200429-19B04-src/src/ada \
        cortex-m0 cortex-m3 cortex-m4 \
        stm32f030f4-hsi stm32f070f6-hsi stm32f051k8-hsi stm32f072rb-hsi \
        nucleo_f401re

FROM ubuntu:20.04

COPY --from=build /usr/local /usr/local
WORKDIR /build
