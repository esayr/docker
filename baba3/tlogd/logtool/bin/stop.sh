#!/bin/bash

cd $(dirname $0)

last_pid=`cat logtool_svrd.pid`
kill -9  $last_pid
ps -ef | grep logtool_svrd
