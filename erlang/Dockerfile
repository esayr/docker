FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8
ENV ERLANG_VERSION 18.0

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

#RUN buildDeps=" \
#        libncurses5-dev \
#        libssl-dev \
#        unixodbc \
#        unixodbc-dev \
#    " && \
#    apt-get update && \
#    apt-get install -y --no-install-recommends build-essential  $buildDeps && \
#    wget http://image.bbgo.qq.com/erlang/otp_src_$ERLANG_VERSION.tar.gz -o erlang.tar.gz && \
#    tar zxvf otp_src_$ERLANG_VERSION.tar.gz && \
#    rm -rf erlang.tar.gz  && \
#    cd otp_src_$ERLANG_VERSION && \
#    export ERL_TOP=`pwd` && \
#    export LANG=C && \
#    ./configure --prefix=/usr/local/erlang --enable-smp-support --enable-threads --enable-kernel-poll --enable-hipe && \
#    make  -j"$(nproc)" && \
#    make install && \
#    make clean && \
#    cd .. && \
#    rm -rf otp_src_$ERLANG_VERSION && \
#    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false #$buildDeps && \
#    apt-get clean && \
#    apt-get autoclean && \
#    rm -fr /var/lib/apt/lists/* && \
#    rm -rf /usr/share/man/?? && \
#    rm -rf /usr/share/man/??_*
#
#ENV PATH /usr/local/erlang/bin:$PATH

RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends erlang build-essential && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps  && \
    apt-get clean && \
    apt-get autoclean && \
    rm -fr erlang-solutions_1.0_all.deb && \
    rm -fr /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*


# rebar mad relx 
COPY bin/* /usr/local/bin/


# Setup Volume
VOLUME ["/data/project"]