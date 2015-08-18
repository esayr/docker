FROM docker.v909.com/cn-ubuntu:14.04

ENV HOMEDIR /reborn
ENV BUILDDIR /tmp/reborn

# upgrade & install required packages
RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y  bash gcc make bzip2 



RUN echo 'root:root' | chpasswd && \
    mkdir -p ${HOMEDIR}  && \
    mkdir -p ${BUILDDIR} && \
    groupadd -r reborn && \
    useradd -r -g reborn reborn -s /bin/bash -d ${HOMEDIR} && \
    echo 'reborn:reborn' | chpasswd


# copy & build redis source code
ADD redis-2.8.13 ${BUILDDIR}
ADD redis-test/conf/6379.conf ${HOMEDIR}/redis.conf
WORKDIR ${BUILDDIR}/src

RUN make distclean  && \
    make -j  && \
    cp redis-server ${HOMEDIR}/reborn-server  && \
    cp redis-cli    ${HOMEDIR}/  && \
    rm -rf ${BUILDDIR}  && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R reborn:reborn ${HOMEDIR}

EXPOSE 6379

CMD ["/reborn/reborn-server", "/reborn/redis.conf"]