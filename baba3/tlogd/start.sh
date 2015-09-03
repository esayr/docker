#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib
export LOGTOOL_HOME=/data/tlogd/logtool
export LOGTOOL_BIN=/data/tlogd/logtool/bin
export LOGTOOL_CFG=/data/tlogd/logtool/cfg
export SYS_CONF_PATH=/data/tlogd/logtool/cfg
export SYS_SOCKET_TIMEOUT=2

  CONFIG_PATH="/data/tlogd/logtool/cfg"
  CONFIG_NAME="logtool_svrd.ini"

  # backup config and create new
  mv ${CONFIG_PATH}/${CONFIG_NAME}  ${CONFIG_PATH}/${CONFIG_NAME}.bak
  cp ${CONFIG_PATH}/${CONFIG_NAME}.example   ${CONFIG_PATH}/${CONFIG_NAME}


  # see http://stackoverflow.com/a/2705678/433558
  sed_escape_lhs() {
    echo "$@" | sed 's/[]\/$*.^|[]/\\&/g'
  }
  sed_escape_rhs() {
    echo "$@" | sed 's/[\/&]/\\&/g'
  }

  set_config() {
    key="$1"
    value="$2"
    regex="$(sed_escape_lhs "$key")"
    if [ "${key:0:1}" = '$' ]; then
      regex="^(\s*)$(sed_escape_lhs "$key")\s*="
    fi
    sed -i "s/$regex/$(sed_escape_rhs "$value")/" ${CONFIG_PATH}/${CONFIG_NAME}
  }


  : ${LOGS_PATH:="/data/logs"}
  : ${DB_HOST:="host"}
  : ${DB_PORT:="3306"}
  : ${DB_USER:="user"}
  : ${DB_PASSWORD:="passwd"}
  : ${DB_NAME:="dbname"}

  set_config 'LOGS_PATH' $LOGS_PATH
  set_config 'DB_HOST' $DB_HOST
  set_config 'DB_PORT' $DB_PORT
  set_config 'DB_USER' $DB_USER
  set_config 'DB_PASSWORD' $DB_PASSWORD
  set_config 'DB_NAME' $DB_NAME

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf