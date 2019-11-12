FROM circleci/ruby:2.3.7-node-browsers-legacy

RUN FILE=`mktemp` &&\
    URL='https://www.princexml.com/download/prince_11.4-1_debian9.1_amd64.deb' &&\
    wget $URL -qO $FILE &&\
    sudo dpkg -i $FILE &&\
    rm -f $FILE

USER root
RUN apt update && \
    apt install libssl-dev && \
    wget https://github.com/Kitware/CMake/releases/download/v3.14.3/cmake-3.14.3-Linux-x86_64.sh \
    -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /usr/bin/cmake \
    && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
    && rm /tmp/cmake-install.sh

# Install libpostal
RUN apt-get update && apt-get install -y \
    autoconf automake build-essential curl git libsnappy-dev libtool pkg-config

RUN git clone https://github.com/openvenues/libpostal

WORKDIR libpostal

RUN ./bootstrap.sh \
    && mkdir -p /opt/libpostal_data \
    && ./configure --datadir=/opt/libpostal_data

RUN make && make install && ldconfig

WORKDIR ..

ENV PATH="/usr/bin/cmake/bin:${PATH}"
