FROM ubuntu:20.04 as src

RUN apt-get update && \
    apt-get install -y curl gzip git

WORKDIR /build

RUN curl -L -o gcc-9-2020-20200429-19AA7-src.tar.gz 'https://community.download.adacore.com/v1/e6b6a3e318e13248456bd37b758435e602b367da?filename=gcc-9-2020-20200429-19AA7-src.tar.gz'
RUN curl -L -o gcc-interface-9-2020-20200429-19B10-src.tar.gz 'https://community.download.adacore.com/v1/c7a97636b31f3575df85f1eb0965462a353630dd?filename=gcc-interface-9-2020-20200429-19B10-src.tar.gz'
RUN curl -O https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz
RUN curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz
RUN curl -L -o gprbuild-2020-20200429-19BD2-src.tar.gz 'https://community.download.adacore.com/v1/408ec35c3bb86bd227db3da55d3e1e0c572a56e3?filename=gprbuild-2020-20200429-19BD2-src.tar.gz'
RUN curl -L -o xmlada-2020-20200429-19A99-src.tar.gz 'https://community.download.adacore.com/v1/c799502295baf074ad17b48c50f621879c392c57?filename=xmlada-2020-20200429-19A99-src.tar.gz'
RUN curl -L -o gnat-2020-20200429-19B04-src.tar.gz 'https://community.download.adacore.com/v1/649a561ec6de9e476c54b02715b79f7503600ce5?filename=gnat-2020-20200429-19B04-src.tar.gz'
RUN git clone --depth 1 --branch community-2020 https://github.com/AdaCore/bb-runtimes.git
RUN curl -L -o cortex-gnat-rts-r20201014.tar.gz https://github.com/simonjwright/cortex-gnat-rts/archive/refs/tags/r20201014.tar.gz
RUN curl -L -o componolit-ada-runtime-1.2.0.tar.gz https://github.com/Componolit/ada-runtime/archive/refs/tags/v1.2.0.tar.gz
RUN git clone --depth 1 --branch v1.0.0 https://github.com/ekoeppen/ada-null-runtime.git
RUN curl -L -o FreeRTOS-V10.0.1.tar.gz 'https://github.com/FreeRTOS/FreeRTOS/archive/refs/tags/V10.0.1.tar.gz'

FROM ubuntu:20.04

WORKDIR /build
COPY --from=src /build /build
