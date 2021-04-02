FROM gnat-cross-src:10.1.0 as build

ARG target=arm-eabi
ENV TARGET=$target

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash libc-dev make texinfo gnat gprbuild g++ zlib1g-dev

WORKDIR /build

COPY *.sh ./
RUN mkdir gcc gcc-boot newlib binutils

RUN export SRC_PATH=/build && cd /build/binutils && ../binutils.sh && \
    cd /build/gcc && ../gcc.sh

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y gprbuild

COPY --from=build /opt/GNAT/10.1.0/$target /opt/GNAT/10.1.0/$target
