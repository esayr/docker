FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update && \
    apt-get update &&  \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends supervisor  && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -fr /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

RUN mkdir -p /tlogd
ADD tlogd /tlogd
RUN chmod +x /tlogd/*.sh


# Supervisor Config
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


VOLUME /data/log

EXPOSE 6660/udp

CMD ["/usr/bin/supervisord"]