#!/bin/bash

#set -e

REL_NAME="baba3_server"
SCRIPT_DIR="$(dirname "$0")"
RELEASE_DIR="$(cd "$SCRIPT_DIR" && pwd)"
SRC_DIR="/data/erlang/baba3_server/"

echo $ARM
docker rm -f baba3-gamesrv
docker rmi baba3/gamesrv


PACKAGE_NAME=$(cd "$SRC_DIR" && ls -1t *.gz | head -5)

cd $RELEASE_DIR

tar -C ./ -zxf  $SRC_DIR/$PACKAGE_NAME

cat > Dockerfile <<EOF
FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV MYSQL_HOST abc.test.com

RUN apt-get update && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends supervisor  && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -fr /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

RUN mkdir -p /data/$REL_NAME
ADD $REL_NAME /data/$REL_NAME
RUN chmod +x /data/$REL_NAME/bin/*


# Supervisor Config
ADD ./supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh


VOLUME /data/log

EXPOSE 8080

CMD ["/bin/bash", "/start.sh"]

EOF

docker build --force-rm -t baba3/gamesrv . 

rm -f Dockerfile
rm -rf $RELEASE_DIR/$REL_NAME 

cd -

#docker run --rm -it baba3/gamesrv /bin/bash
