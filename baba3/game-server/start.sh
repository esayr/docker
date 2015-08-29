#!/bin/bash
set -e

  CONFIG_PATH="/data/baba3_server/config/default"
  CONFIG_NAME="sys.config"

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

  : ${SERVER_PORT:=8080}
  : ${IDIP_SWITCH:=true}
  : ${CHAT_SERVER:=0} #0:表示聊天服和正常服都能运行； 1:表示只能运行聊天服  2:只运行正常服

  : ${REDIS_DB_HOST:="redis.baba.com"}
  : ${REDIS_DB_PORT:=3790}
  : ${REDIS_DB_PASSWORD:=''}
  : ${REDIS_DB_POOL_SIZE:=10}

  : ${TLOG_SERVER:='["tlog1.baba.com","tlog2.baba.com"]'}
  : ${TLOG_PORT:=6660}

  : ${DB_HOST:="db.baba.com"}
  : ${DB_PORT:="3306"}
  : ${DB_USER:="baba3"}
  : ${DB_PASSWORD:="baba3\$erlang"}
  : ${DB_NAME:="db_baba3"}
  : ${DB_POOL_SIZE:=10}


  # server
  set_config 'SERVER_PORT' $SERVER_PORT
  set_config 'IDIP_SWITCH' $IDIP_SWITCH
  set_config 'CHAT_SERVER' $CHAT_SERVER

  # redis
  set_config 'REDIS_DB_HOST' $REDIS_DB_HOST
  set_config 'REDIS_DB_PORT' $REDIS_DB_PORT
  set_config 'REDIS_DB_PASSWORD' $REDIS_DB_PASSWORD
  set_config 'REDIS_DB_POOL_SIZE' $REDIS_DB_POOL_SIZE

  # tlog
  set_config 'TLOG_SERVER' $TLOG_SERVER
  set_config 'TLOG_PORT' $TLOG_PORT

  # mysql database
  set_config 'DB_HOST' $DB_HOST
  set_config 'DB_PORT' $DB_PORT
  set_config 'DB_USER' $DB_USER
  set_config 'DB_PASSWORD' $DB_PASSWORD
  set_config 'DB_NAME' $DB_NAME
  set_config 'DB_POOL_SIZE' $DB_POOL_SIZE


# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf