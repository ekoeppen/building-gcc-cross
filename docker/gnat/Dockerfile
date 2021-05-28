ARG registry

FROM ${registry}gnat-cross-src:community-2021 as build

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
COPY patches/linker-msp430.patch /tmp/
RUN cd /usr/local/share/gprconfig && patch -p0 < /tmp/linker-msp430.patch

COPY binutils.sh gcc.sh common.sh patches/gcc-remove-jorvik.patch /build/
RUN mkdir gcc gcc-boot binutils && \
    tar xf gcc-10-2021-20210519-19A74-src.tar.gz && \
    tar xf gnat-2021-20210519-19A70-src.tar.gz && \
    tar xf gcc-interface-10-2021-20210519-19A75-src.tar.gz && \
    tar xf binutils-2.34.tar.gz && \
    cd /build/gcc-10-2021-20210519-19A74-src/ && ./contrib/download_prerequisites && \
    cd /build && \
    mv gnat-2021-20210519-19A70-src/src/ada gcc-10-2021-20210519-19A74-src/gcc/ada && \
    mv gcc-interface-10-2021-20210519-19A75-src gcc-10-2021-20210519-19A74-src/gcc/ada/gcc-interface && \
    patch -p0 < gcc-remove-jorvik.patch

RUN cd /build/binutils && ../binutils.sh
RUN cd /build/gcc && ../gcc.sh

COPY newlib.sh ./
RUN cd /build && mkdir newlib && tar xf newlib-3.3.0.tar.gz
RUN cd /build/newlib && ../newlib.sh

COPY bb-runtimes.sh ./
RUN git clone --depth 1 --branch community-2021 https://github.com/ekoeppen/bb-runtimes.git
RUN cd /build/bb-runtimes && \
    ../bb-runtimes.sh /usr/local/arm-eabi/lib/gnat /build/gcc-10-2021-20210519-19A74-src/ /build/gcc-10-2021-20210519-19A74-src/gcc/ada/ \
        cortex-m0 cortex-m3 cortex-m4 cortex-m4f

RUN git clone --depth 1 --branch v1.0.2 https://github.com/ekoeppen/ada-null-runtime.git
RUN cd /build/ada-null-runtime && \
    gprbuild -p -P rts_null.gpr -XTarget=${TARGET} && \
    gprinstall -p -P rts_null.gpr -XTarget=${TARGET}

FROM ubuntu:20.04

COPY --from=build /usr/local /usr/local
COPY --from=build /build/gcc-10-2021-20210519-19A74-src/gcc/ada/ /usr/local/include/rts-sources/
COPY --from=build /build/gcc-10-2021-20210519-19A74-src/libgcc/unwind*.h /usr/local/include/gcc/libgcc/
WORKDIR /build
