FROM ubuntu:16.04
MAINTAINER Nanyc Team

RUN apt-get update
RUN apt-get --yes upgrade
RUN apt-get --yes install apt-utils build-essential wget unzip

ENV CMAKE_VERSION 3.7.1
RUN wget --quiet "https://cmake.org/files/v3.7/cmake-${CMAKE_VERSION}.tar.gz"
RUN tar zxf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION}/ && ./configure && make -j$(nproc) && ./bin/cpack -G DEB \
    && dpkg -i cmake-*.deb \
    && cd .. && rm -rf cmake-*
