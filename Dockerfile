FROM circleci/ruby:2.3.7-node-browsers

RUN sudo apt-get update
RUN sudo apt-get install -y -f libjpeg8
RUN sudo apt-get install -y -f libpng12-0
RUN sudo apt-get install -y -f libssl1.0.0

RUN URL='https://www.princexml.com/download/prince_12.1-1_ubuntu14.04_amd64.deb' && FILE=`mktemp` && wget "$URL" -qO $FILE && sudo dpkg -i $FILE; sudo apt-get update && sudo apt-get install -y -f && sudo dpkg -i $FILE && rm $FILE
