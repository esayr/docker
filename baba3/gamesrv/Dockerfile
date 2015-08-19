FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

RUN LANG=C perl -e exit


VOLUME ["/data/log"]

EXPOSE 30080

CMD ["/data/baba3_server/bin/server", "start"]