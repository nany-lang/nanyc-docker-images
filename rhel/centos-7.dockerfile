FROM centos:7.3.1611
MAINTAINER Nanyc Team

RUN yum -y update
RUN yum -y install gcc gcc-c++ make coreutils curl
RUN yum -y install centos-release-scl
RUN yum -y install devtoolset-6-gcc devtoolset-6-gcc-c++ devtoolset-6-make wget
RUN yum -y install rpm-build redhat-rpm-config
RUN yum -y install unzip gzip tar

# Enable devtoolset and ccache system-wide
# See /opt/rh/devtoolset-6/enable
ENV PATH=/usr/lib64/ccache:/opt/rh/devtoolset-6/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/opt/rh/devtoolset-6/root/usr/lib64:/opt/rh/devtoolset-6/root/usr/lib
ENV PERL5LIB=/opt/rh/devtoolset-6/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-6/root/usr/lib/perl5:/opt/rh/devtoolset-6/root//usr/share/perl5/vendor_perl
ENV PYTHONPATH=/opt/rh/devtoolset-6/root/usr/lib64/python2.7/site-packages:/opt/rh/devtoolset-6/root/usr/lib/python2.7/site-packages
ENV XDG_CONFIG_DIRS=/opt/rh/devtoolset-6/root/etc/xdg:/etc/xdg
ENV XDG_DATA_DIRS=/opt/rh/devtoolset-6/root/usr/share:/usr/local/share:/usr/share

RUN gcc --version
RUN g++ --version

ENV CMAKE_VERSION 3.7.1
RUN wget --quiet "https://cmake.org/files/v3.7/cmake-${CMAKE_VERSION}.tar.gz"
RUN tar zxf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION}/ && ./configure && make -j$(nproc) \
    && ./bin/cpack -G RPM \
    && yum localinstall -y cmake-*.rpm \
    && cd .. && rm -rf cmake-*
