#!/bin/sh
cd $(dirname $0)
${PWD}/stop_tlogd.sh
rm -rf ${PWD}/tlogd.pid
${PWD}/tlogd --conf-file=./tlogd_bin_vec.xml --log-level=600 --log-file=./tlogd --pid-file=./tlogd.pid --daemon start