FROM docker.v909.com/nginx-php

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

ADD yaf.so /usr/lib/php5/20121212/
ADD yaf.ini /etc/php5/mods-available/


RUN ln -s /etc/php5/mods-available/yaf.ini /etc/php5/fpm/conf.d/20-yaf.ini