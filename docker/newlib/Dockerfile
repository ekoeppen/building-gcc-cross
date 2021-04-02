ARG registry
ARG target=arm-eabi

FROM ${registry}gnat-cross-${target}:10.1.0 as build

ARG target=arm-eabi
ENV TZ=Europe/Helsinki
ENV TARGET=$target

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y file bash gzip curl \
    libc-dev make texinfo g++ zlib1g-dev

WORKDIR /build

COPY *.sh ./

RUN mkdir gcc gcc-boot newlib binutils && \
    curl https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz | tar xzf -

RUN export SRC_PATH=/build && \
    export PATH=$PATH:/opt/GNAT/10.1.0/${target}/bin &&  \
    cd /build/newlib && ../newlib.sh

FROM ubuntu:20.04

COPY --from=build /opt/GNAT/10.1.0 /opt/GNAT/10.1.0
