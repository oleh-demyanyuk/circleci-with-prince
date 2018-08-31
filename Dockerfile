FROM circleci/ruby:2.3.7-node-browsers

RUN URL='https://www.princexml.com/download/prince_10r7-1_debian8.0_amd64.deb' && FILE=`mktemp` && wget "$URL" -qO $FILE && sudo dpkg -i $FILE; sudo apt-get update && sudo apt-get install -y -f && sudo dpkg -i $FILE && rm $FILE
