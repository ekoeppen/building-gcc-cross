ARG registry

FROM ${registry}gnat-cross-src:10.2.0 as build

ARG target=arm-eabi
ENV TARGET=$target

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash curl gzip \
    libc-dev make texinfo gnat-10 gprbuild g++ zlib1g-dev

WORKDIR /build

COPY *.sh ./

RUN mkdir gcc gcc-boot newlib binutils && \
    tar xf gcc-10.2.0.tar.gz && \
    tar xf binutils-2.34.tar.gz && \
    cd gcc-10.2.0/ && ./contrib/download_prerequisites

RUN export SRC_PATH=/build && export CC=gcc-10 && export PREFIX=/usr/local && \
    cd /build/binutils && ../binutils.sh && \
    cd /build/gcc && ../gcc.sh

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y gprbuild

COPY --from=build /usr/local /usr/local
