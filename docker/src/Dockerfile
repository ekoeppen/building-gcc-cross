FROM ubuntu:20.04 as base

RUN apt-get update && \
    apt-get install -y curl gzip 

WORKDIR /build

RUN cd /build && curl https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.gz | tar xzf - && \
    cd /build && curl https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz | tar xzf - && \
    cd /build && curl https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz | tar xzf - && \
    cd /build/gcc-10.1.0/ && ./contrib/download_prerequisites
