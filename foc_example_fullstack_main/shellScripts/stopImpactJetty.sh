#!/bin/sh
readonly SCRIPT_NAME=$(basename $0)

log() {
  echo "$@"
  logger -p user.notice -t $SCRIPT_NAME "$@"
}

err() {
  echo "$@" >&2
  logger -p user.error -t $SCRIPT_NAME "$@"
}

#if [ -z "$(fuser 2501/tcp)" ]
#then
#      log "Jetty not started on port 2501. Nothing to stop"
#else
#      log "Jetty already started on port 2501. Will stop"
#      fuser -k 2501/tcp
#fi
echo "killing jetty on port 2501 if running already"
ps aux | egrep 'FenixCovidAPIServer.*2501' | grep -v grep | awk -F ' ' '{print $2}' | while read pid; do kill -9 $pid; done

echo "killing sms jetty on port 2600 if running already"
ps aux | egrep 'FenixSmsServer.*2600' | grep -v grep | awk -F ' ' '{print $2}' | while read pid; do kill -9 $pid; done

if [ -z "$(ps aux | grep 'inotifywait -m -e create /opt/hosting/impact_app_municipalities_published' | grep -v grep | awk -F ' ' '{print $2}')" ]
then
    log "Currently not watching for changes in /opt/hosting/impact_app_municipalities_published . Nothing to stop" 
else
    log "Currently watching for changes in /opt/hosting/impact_app_municipalities_published . Will stop"
    ps aux | grep 'inotifywait -o /tmp/impactjetty.log -d /opt/hosting/impact_app_municipalities_published/ROOT' | grep -v grep | awk -F ' ' '{print $2}' | xargs kill -9
fi
