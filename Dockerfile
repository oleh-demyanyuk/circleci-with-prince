FROM circleci/ruby:2.3.7-node-browsers

RUN sudo apt-get update && apt-get upgrade -y
RUN sudo apt-get install -y -f libjpeg-turbo8-dev

RUN URL='https://www.princexml.com/download/prince_12.1-1_ubuntu16.04_amd64.deb' && FILE=`mktemp` && wget "$URL" -qO $FILE && sudo dpkg -i $FILE; sudo apt-get update && sudo apt-get install -y -f && sudo dpkg -i $FILE && rm $FILE
