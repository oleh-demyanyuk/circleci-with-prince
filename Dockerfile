# the Ubuntu version of base image is 20.04.3 LTS
# https://circleci.com/developer/images/image/cimg/ruby
FROM cimg/ruby:2.7.5-browsers

# https://www.princexml.com/download/
RUN FILE=`mktemp` &&\
    URL='https://www.princexml.com/download/prince_14.3-1_ubuntu20.04_amd64.deb' && \
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

WORKDIR ..

ENV PATH="/usr/bin/cmake/bin:${PATH}"
