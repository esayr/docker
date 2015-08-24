FROM docker.v909.com/ubuntu:14.04

ENV HOMEDIR /reborn-proxy


RUN echo 'root:root' | chpasswd && \
    mkdir -p ${HOMEDIR}  && \
    groupadd -r reborn && \
    useradd -r -g reborn reborn -s /bin/bash -d ${HOMEDIR} && \
    echo 'reborn:reborn' | chpasswd


# copy & chmod
ADD bin ${HOMEDIR}/
ADD redis.conf ${HOMEDIR}/redis.conf

RUN chown -R reborn:reborn ${HOMEDIR} && chmod +x ${HOMEDIR}/bin/reborn-*
RUN echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf

VOLUME ["/var/lib/redis"]

EXPOSE 6379

CMD ["/reborn/reborn-server", "/reborn/redis.conf"]

# docker build -t reborn/server reborn/reborn-server/
# docker run  -d --name reborn-server  -p 8001:6379 -v /redis/db:/var/lib/redis  reborn/server