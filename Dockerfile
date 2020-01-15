FROM circleci/ruby:2.6.5-stretch-node-browsers-legacy

RUN FILE=`mktemp` &&\
    URL='https://www.princexml.com/download/prince_11.4-1_debian9.1_amd64.deb' &&\
    wget $URL -qO $FILE &&\
    sudo dpkg -i $FILE &&\
    rm -f $FILE

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  software-properties-common \
  pkg-config \
  openssl \
  libssl-dev \
  nodejs

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
