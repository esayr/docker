FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

ENV MONGO_VERSION 3.1.6

# Installation steps based on http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        mongodb-org-unstable=$MONGO_VERSION \
        mongodb-org-unstable-server=$MONGO_VERSION \
        mongodb-org-unstable-shell=$MONGO_VERSION \
        mongodb-org-unstable-mongos=$MONGO_VERSION \
        mongodb-org-unstable-tools=$MONGO_VERSION && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME /data/db

EXPOSE 27017
CMD    ["mongod"]