#!/bin/bash
set -e
#./checklog -skipflag 0 -logpath /data/logplat/log/tlogd_1/test.log -charflag \| -xml novachina-log_20110511.xml -exportdir ./badlog_20110511

g_skipflag="|"
g_charflag="NO"

SCRIPT_DIR="$(dirname "$0")"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CHECKLOG=$ROOT_DIR/checklog

check_log()
{
   #./checklog -skipflag "$g_skipflag" -logpath "$g_logpath" -charflag "$g_charflag" -xml "$g_xmlfile" -exportdir "$g_exportdir" $g_colprefix
   $CHECKLOG -skipflag "$g_skipflag" -logpath "$g_logpath" -charflag "$g_charflag" -xml "$g_xmlfile" -exportdir "$g_exportdir"
   if [ $? -ne 0 ];then
       echo "check error"
       exit 1
   fi
}


while [ $# -ne 0 ]
do
  case $1 in
  -p)
    shift
    g_logpath=$1
    ;;
  -x)
    shift
    g_xmlfile=$1
    ;;
  -o)
    shift
    g_exportdir=$1
    ;;
  #-colprefix)
    #g_colprefix="-colprefix"
    #;;
  --help)
    echo "    -p: check the logfiles path"
    echo "    -x: check the xml path"
    echo "    -o: error log output dir"
    exit 1
    ;;
  *)
    echo "[FATAL LOG][`date +%y/%m/%d-%H:%M:%S`]:symbol <$1> Illegal"
    echo "please try `sh $0 --help` get more information"
    exit 1
  esac
  shift
done

if [ -z "$g_exportdir" ];then
    g_exportdir='./'
fi

if [ -z "$g_logpath" -o -z "$g_xmlfile" ];then
    #echo "g_logpath or g_xmlfile or g_exportdir is null"
    echo "usage: check_log.sh  -p /path/to/logfile -x /path/to/logfile -o /path/to/error_output_dir"
    exit 1
fi

check_log