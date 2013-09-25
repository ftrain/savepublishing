#!/bin/bash
# NGINX RC.D SCRIPT
# Archlinux

DIR=`pwd`
NGINX_CONFIG=$DIR"/../etc/nginx/nginx.local.conf"
NGINX_BIN=""

function check_config {
  stat_busy "Checking configuration"
  "$NGINX_BIN"nginx -t -c "$NGINX_CONFIG"
  if [ $? -ne 0 ]; then
    stat_die
  else
    stat_done
  fi
}

case "$1" in
  start)
    check_config
    stat_busy "Starting Nginx"
    if [ -s /var/run/nginx.pid ]; then
      stat_fail
      # probably ;)
      stat_busy "Nginx is already running"
      stat_die
     fi
    "$NGINX_BIN"nginx -c "$NGINX_CONFIG" &>/dev/null
    if [ $? -ne 0 ]; then
      stat_fail
    else
      add_daemon nginx
      stat_done
    fi
    ;;
  stop)
    stat_busy "Stopping Nginx"
    kill -QUIT `cat /var/run/nginx.pid` &>/dev/null
    if [ $? -ne 0 ]; then
      stat_fail
    else
      rm_daemon nginx
      stat_done
    fi
    ;;
  restart)
    $0 stop
    sleep 1
    $0 start
    ;;
  reload)
    check_config
    if [ -s /var/run/nginx.pid ]; then
      status "Reloading Nginx Configuration" kill -HUP `cat /var/run/nginx.pid`
    fi
    ;;
  check)
    check_config
    ;;
  *)
    echo "usage: $0 {start|stop|restart|reload|check}"  
esac
