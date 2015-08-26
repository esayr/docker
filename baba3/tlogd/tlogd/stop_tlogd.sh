#!/bin/sh
cd $(dirname $0)
./tlogd --pid-file=./tlogd.pid stop
