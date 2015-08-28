FROM centos:6.6

MAINTAINER Easy Rong <phpvcn@php.net>

RUN yum -y install glibc.i686 gtk2.i686 python-setuptools

#Install supervisor
RUN easy_install supervisor

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /data/tlogd
RUN mkdir -p /data/logs

ADD tlogd /data/tlogd/tlogd-server
ADD logtool /data/tlogd/logtool
ADD tools /data/tlogd/tools

RUN chmod +x /data/tlogd/tlogd-server/*.sh
RUN chmod +x /data/tlogd/logtool/bin/*.sh


# Supervisor Config
ADD ./supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME /data/logs

EXPOSE 6660/udp

CMD ["/bin/bash", "/start.sh"]