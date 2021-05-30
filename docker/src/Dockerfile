FROM ubuntu:21.04 as src

RUN apt-get update && \
    apt-get install -y curl gzip git

WORKDIR /build

RUN curl -L -o gcc-11.1.0.tar.gz https://github.com/gcc-mirror/gcc/archive/refs/tags/releases/gcc-11.1.0.tar.gz
RUN curl -L -o gnat-2021-20210519-19A70-src.tar.gz 'https://community.download.adacore.com/v1/005d2b2eff627177986d2517eb31e1959bec6f3a?filename=gnat-2021-20210519-19A70-src.tar.gz'
RUN curl -O https://sourceware.org/pub/newlib/newlib-4.1.0.tar.gz
RUN curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz
RUN curl -L -o gprbuild-2020-20200429-19BD2-src.tar.gz 'https://community.download.adacore.com/v1/408ec35c3bb86bd227db3da55d3e1e0c572a56e3?filename=gprbuild-2020-20200429-19BD2-src.tar.gz'
RUN curl -L -o xmlada-2020-20200429-19A99-src.tar.gz 'https://community.download.adacore.com/v1/c799502295baf074ad17b48c50f621879c392c57?filename=xmlada-2020-20200429-19A99-src.tar.gz'

FROM ubuntu:21.04

WORKDIR /build
COPY --from=src /build /build
