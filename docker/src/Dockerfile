FROM ubuntu:20.04 as src

RUN apt-get update && \
    apt-get install -y curl gzip git

WORKDIR /build

RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz && \
    curl -O https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz && \
    curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz && \
    git clone --depth 1 --branch v21.0.0 https://github.com/AdaCore/xmlada.git && \
    git clone --depth 1 --branch v21.0.0 https://github.com/AdaCore/gprbuild.git && \
    git clone --depth 1 https://github.com/AdaCore/gprconfig_kb && \
    curl -L -o gnat-2020-20200429-19B04-src.tar.gz 'https://community.download.adacore.com/v1/649a561ec6de9e476c54b02715b79f7503600ce5?filename=gnat-2020-20200429-19B04-src.tar.gz' && \
    git clone --depth 1 --branch community-2020 https://github.com/AdaCore/bb-runtimes.git && \
    curl -L -o cortex-gnat-rts-r20201014.tar.gz https://github.com/simonjwright/cortex-gnat-rts/archive/refs/tags/r20201014.tar.gz && \
    curl -L -o componolit-ada-runtime-1.2.0.tar.gz https://github.com/Componolit/ada-runtime/archive/refs/tags/v1.2.0.tar.gz && \
    git clone --depth 1 --branch v1.0.0 https://github.com/ekoeppen/ada-null-runtime.git

FROM ubuntu:20.04

WORKDIR /build
COPY --from=src /build /build
