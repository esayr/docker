FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV MYSQL_HOST abc.test.com

RUN apt-get update &&     apt-get update &&     apt-get upgrade -y &&     apt-get install -y --no-install-recommends supervisor  &&     apt-get autoremove -y &&     apt-get clean &&     apt-get autoclean &&     rm -fr /var/lib/apt/lists/* &&     rm -rf /usr/share/man/?? &&     rm -rf /usr/share/man/??_*

RUN mkdir -p /data/baba3_server
ADD baba3_server /data/baba3_server
RUN chmod +x /data/baba3_server/bin/*


# Supervisor Config
ADD ./supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh


VOLUME /data/log

EXPOSE 8080

CMD ["/bin/bash", "/start.sh"]

