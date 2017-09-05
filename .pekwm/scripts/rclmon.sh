#!/bin/sh
# Copyright  (C) 2006 J.F.Dockes
#gpl
###################
# Start/stop a recollindex program running as permanent real time indexer.
# The running program writes its pid in $RECOLL_CONFDIR/index.pid
# The portability of this script has not been fully tested.
#

fatal()
{
    echo $*
    exit 1
}
usage()
{
    fatal "Usage: rclmon.sh <start|stop>"
}

test $# -eq 1 || usage

export LANG=C

RECOLL_CONFDIR=${RECOLL_CONFDIR:-$HOME/.recoll}
#echo RECOLL_CONFDIR = ${RECOLL_CONFDIR}

pidfile="${RECOLL_CONFDIR}/index.pid"
opid=0


if test -f $pidfile ; then
   read opid junk < $pidfile
fi

if test $opid -gt 0; then
   out=`kill -0 ${opid} 2>&1`
   if test $? -ne 0 ; then
      if test `expr "$out" : '.*such *process.*'` -ne 0 ; then	
	 opid=0
      else 
	 fatal cant test existence of running process 
      fi
   fi
fi

#echo "Existing pid $opid"

case $1 in
     start)
	if test "$opid" -ne 0 ; then
	   fatal "Already running process: $opid"
	fi
	recollindex -m
     ;;
     stop)
	if test "$opid" -eq 0 ; then
	   fatal "No process running"
	fi
	kill $opid
     ;;
     *)
     usage
esac

