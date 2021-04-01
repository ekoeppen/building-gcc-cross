FROM ubuntu:20.04 as build

ARG target=arm-eabi
ENV TARGET=$target
ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y git curl gzip bash libc-dev make curl gzip texinfo \
    gnat gprbuild g++ zlib1g-dev

WORKDIR /build

RUN cd /build && curl https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.gz | tar xzf - && \
    cd /build && curl https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz | tar xzf - && \
    cd /build && curl https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz | tar xzf - && \
    cd /build/gcc-10.1.0/ && ./contrib/download_prerequisites

COPY *.sh ./
RUN mkdir gcc gcc-boot newlib binutils

RUN export SRC_PATH=/build && cd /build/binutils && ../binutils.sh && \
    cd /build/gcc-boot && ../gcc-boot.sh && \
    cd /build/newlib && ../newlib.sh && \
    cd /build/gcc && ../gcc.sh

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y gprbuild

COPY --from=build /opt/GNAT-10.1.0/$target /opt/GNAT-10.1.0/$target
