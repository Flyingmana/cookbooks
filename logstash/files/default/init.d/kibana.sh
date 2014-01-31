#! /bin/sh
# /etc/init.d/kibana
#

# Some things that run always
# touch /var/lock/blah

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo -n "Starting kibana: "
    cd /opt/kibana/Kibana-0.2.0
    nohup ruby kibana.rb > /dev/null 2> /dev/null < /dev/null &
    echo "."
    ;;
  stop)
    echo -n "Stopping kibana: "
    ps auxww | grep 'kibana' | grep ruby |  kill -TERM $(awk '{print $2}')
    echo "."
    ;;
  status)
    echo -n "Status kibana: "
    ps auxww | grep 'kibana' | grep ruby | echo $(awk '{print $2}')
    echo "."
    ;;
  *)
    echo "Usage: /etc/init.d/kibana {start|stop|status}"
    exit 1
    ;;
esac

exit 0
