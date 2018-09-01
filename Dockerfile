FROM circleci/ruby:2.3.7-node-browsers

RUN FILE=`mktemp` &&\
    URL='https://www.princexml.com/download/prince_11.4-1_debian9.1_amd64.deb' &&\
    wget $URL -qO $FILE &&\
    sudo dpkg -i $FILE &&\
    rm -f $FILE
