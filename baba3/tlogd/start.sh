#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib
export LOGTOOL_HOME=/data/tlogd/logtool
export LOGTOOL_BIN=/data/tlogd/logtool/bin
export LOGTOOL_CFG=/data/tlogd/logtool/cfg
export SYS_CONF_PATH=/data/tlogd/logtool/cfg
export SYS_SOCKET_TIMEOUT=2

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf