if [ $# -lt 1 ]
then
{
    echo "Usage:$0 <svrd_name>"
    exit 1
}
fi

cd $(dirname $0)/..

SVRD_NAME=$1
export LD_LIBRARY_PATH=/usr/local/lib
export LOGTOOL_HOME=${PWD}
export LOGTOOL_BIN=${LOGTOOL_HOME}/bin/
export LOGTOOL_CFG=${LOGTOOL_HOME}/cfg/
#export NLS_LANG=American_America.US7ASCII
# for itc oper  
export SYS_CONF_PATH=${LOGTOOL_CFG}
export SYS_SOCKET_TIMEOUT=2

echo "[INFO LOG][`date +%y/%m/%d-%H:%M:%S`]:ps -efww|grep ${LOGTOOL_BIN}|grep logtool_svrd|grep -v start.sh|grep -v grep" >>${LOGTOOL_BIN}/restart.log
ps -efww|grep ${LOGTOOL_BIN}|grep logtool_svrd|grep -v start.sh|grep -v grep  >>${LOGTOOL_BIN}/restart.log
ifrun=`ps -efww|grep ${LOGTOOL_BIN}|grep logtool_svrd|grep -v start.sh|grep -v grep|wc -l`
if [ ${ifrun} -ne 0 ]
then
        echo "[FATAL LOG][`date +%y/%m/%d-%H:%M:%S`]:logtool_svrd is running" >>${LOGTOOL_BIN}/restart.log
        exit 0
fi

ulimit -c unlimited
ulimit -n 20480
${LOGTOOL_BIN}/${SVRD_NAME} $2 1>>${LOGTOOL_BIN}/start.log 2>&1 &