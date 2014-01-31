#! /bin/sh
#
#	/etc/rc.d/init.d/logstash
#
#	Starts Logstash as a daemon
#
# chkconfig: 2345 20 80
# description: Starts Logstash as a daemon
# pidfile: /var/run/logstash-agent.pid

### BEGIN INIT INFO
# Provides: logstash
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: S 0 1 6
# Short-Description: Logstash
# Description: Starts Logstash as a daemon.
# Modified originally from https://gist.github.com/2228905#file_logstash.sh

### END INIT INFO

# Amount of memory for Java
#JAVAMEM=256M

# Location of logstash files
LOCATION=/opt/logstash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
DESC="Logstash Daemon"
NAME=java
DAEMON=`which java`
CONFIG_DIR=/opt/logstash/logstash.conf
LOGFILE=/opt/logstash/logstash.log
PATTERNSPATH=/opt/logstash/patterns
JARNAME=logstash-monolithic.jar
#ARGS="-Xmx$JAVAMEM -Xms$JAVAMEM -jar ${JARNAME} agent --config ${CONFIG_DIR} --log ${LOGFILE} --grok-patterns-path ${PATTERNSPATH}"
#ARGS="-jar ${JARNAME} agent --config ${CONFIG_DIR} --log ${LOGFILE} --grok-patterns-path ${PATTERNSPATH}  -- web -l /opt/logstash/logstash-web.log -a '127.0.0.1' --backend elasticsearch:///?local"
ARGS="-jar ${JARNAME} agent --config ${CONFIG_DIR} --log ${LOGFILE} --grok-patterns-path ${PATTERNSPATH}"
SCRIPTNAME=/etc/init.d/logstash
PIDFILE=/var/run/logstash.pid
base=logstash

# Exit if the package is not installed
if [ ! -x "$DAEMON" ]; then
{
  echo "Couldn't find $DAEMON"
  exit 99
}
fi

#. /etc/init.d/functions

#
# Function that starts the daemon/service
#
do_start()
{
  cd $LOCATION && \
  ($DAEMON $ARGS &) \
  && echo "success" || echo "failure"
}

set_pidfile()
{
  ps auxww | grep 'logstash.*monolithic' | grep java | awk '{print $2}' > $PIDFILE
}

#
# Function that stops the daemon/service
#
do_stop()
{
  pid=`cat $PIDFILE`
  kill -TERM $pid
}

case "$1" in
  start)
    echo -n "Starting $DESC: "
    do_start
    touch /var/lock/$JARNAME
    set_pidfile
    # if init.d script does not work correct try this:
    # cd /opt/logstash
    # nohup /usr/bin/java -jar logstash-monolithic.jar agent --config /opt/logstash/logstash.conf --log /opt/logstash/logstash.log --grok-patterns-path /opt/logstash/patterns -- web -l /opt/logstash/logstash-web.log -a '127.0.0.1' --backend elasticsearch:///?local > /dev/null  2> /dev/null &
    ;;
  stop)
    echo -n "Stopping $DESC: "
    do_stop
    rm /var/lock/$JARNAME
    rm $PIDFILE
    ;;
  restart|reload)
    echo -n "Restarting $DESC: "
    do_stop
    do_start
    touch /var/lock/$JARNAME
    set_pidfile
    ;;
  status)
    PID=`ps auxww | grep 'logstash.*monolithic' | grep java | awk '{print $2}'`
    if [ "x$PID" != "x" ]; then
        echo "Running: PID:$PID"
    else
        echo "Stopped"
    fi
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|status|restart}" >&2
    exit 3
    ;;
esac

echo
exit 0
