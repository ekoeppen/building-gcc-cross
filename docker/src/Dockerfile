FROM ubuntu:20.04 as src

RUN apt-get update && \
    apt-get install -y curl gzip git

WORKDIR /build

RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz && \
    curl -O https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz && \
    curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz && \
    git clone --depth 1 --branch v21.0.0 https://github.com/AdaCore/xmlada.git && \
    git clone --depth 1 --branch v21.0.0 https://github.com/AdaCore/gprbuild.git && \
    git clone --depth 1 https://github.com/AdaCore/gprconfig_kb

FROM ubuntu:20.04

WORKDIR /build
COPY --from=src /build /build
