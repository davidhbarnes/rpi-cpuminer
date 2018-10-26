#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM            resin/rpi-raspbian:latest
MAINTAINER      David H. Barnes <david@davidbarnes.net>

RUN             apt-get update -qq && \
                apt-get install -qqy build-essential && \ 
                apt-get install -qqy automake libcurl4-openssl-dev git make

RUN             git clone https://github.com/davidhbarnes/rpi-cpuminer

RUN             cd cpuminer && \
                ./autogen.sh && \
                ./configure CFLAGS="-O3 -mfpu=neon" && \
                make

WORKDIR         /cpuminer
ENTRYPOINT      ["./minerd"]
