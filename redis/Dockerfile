FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

RUN LANG=C perl -e exit

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends redis-server && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_* && \
    update-rc.d -f redis-server disable && \
    sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
    sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf

VOLUME ["/var/lib/redis"]

EXPOSE 6379

CMD ["/usr/bin/redis-server", "/etc/redis/redis.conf"]