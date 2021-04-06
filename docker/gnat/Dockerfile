ARG registry

FROM ${registry}gnat-cross-src:10.2.0 as build

ARG target=arm-eabi
ENV TARGET=$target

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash curl gzip \
    libc-dev make texinfo gnat-10 g++ zlib1g-dev
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && \
    ln -s /usr/lib/gcc/x86_64-linux-gnu/10 /usr/lib/gcc/x86_64-linux-gnu/10.2.0

WORKDIR /build

COPY *.sh ./

RUN cd /build/gprbuild && ./bootstrap.sh --with-xmlada=../xmlada && \
    cd /build/xmlada && ./configure --prefix=/usr/local && \
    make && make install && \
    cd /build/gprbuild && export GPR_PROJECT_PATH=/usr/local/share/gpr && \
    make prefix=/usr/local setup && make all && make install && \
    make libgpr.build && make libgpr.install

RUN mkdir gcc gcc-boot newlib binutils && \
    tar xf gcc-10.2.0.tar.gz && \
    tar xf binutils-2.34.tar.gz && \
    cd gcc-10.2.0/ && ./contrib/download_prerequisites

RUN export SRC_PATH=/build && export CC=gcc-10 && export PREFIX=/usr/local && \
    cd /build/binutils && ../binutils.sh && \
    cd /build/gcc && ../gcc.sh

FROM ubuntu:20.04

COPY --from=build /usr/local /usr/local
WORKDIR /build
