# the Ubuntu version of base image is 20.04.3 LTS
# https://circleci.com/developer/images/image/cimg/ruby
FROM cimg/ruby:2.7.5-browsers

# https://www.princexml.com/download/
RUN FILE=`mktemp` &&\
    URL='https://www.princexml.com/download/prince_14.2-1_ubuntu20.04_amd64.deb' &&\
    wget $URL -qO $FILE &&\
    sudo dpkg -i $FILE &&\
    rm -f $FILE

USER root
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  software-properties-common \
  pkg-config \
  openssl \
  libssl-dev \
  nodejs

# Install libpostal
RUN apt-get update && apt-get install -y curl autoconf automake libtool pkg-config
RUN git clone https://github.com/openvenues/libpostal
WORKDIR libpostal
RUN ./bootstrap.sh
RUN mkdir -p /opt/libpostal_data
RUN ./configure --datadir=/opt/libpostal_data
RUN make -j4
RUN sudo make install && ldconfig

WORKDIR ..

ENV PATH="/usr/bin/cmake/bin:${PATH}"
