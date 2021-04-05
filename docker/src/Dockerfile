FROM ubuntu:20.04 as src

RUN apt-get update && \
    apt-get install -y curl gzip 

WORKDIR /build

RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz && \
    curl -O https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz && \
    curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz

FROM ubuntu:20.04

WORKDIR /build
COPY --from=src /build /build
