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

monitor() {

    inotifywait -m -e create /opt/hosting/impact_app_municipalities_published |
         while read path action file; do
            if [ "ROOT" = "$file" ]; then
              echo "killing jetty on port 2501 if running already"
              ps aux | egrep 'FenixCovidAPIServer.*2501' | grep -v grep | awk -F ' ' '{print $2}' | while read pid; do kill -9 $pid; done

              echo "killing sms jetty on port 2600 if running already"
              ps aux | egrep 'FenixSmsServer.*2600' | grep -v grep | awk -F ' ' '{print $2}' | while read pid; do kill -9 $pid; done



              #if [ -z "$(fuser 2501/tcp)" ]
              #then
              #   log "Jetty already started, while impact was modified"
              #   fuser -k 2501/tcp
              #   log "killed jetty on port 2501"
              # else
              #   log "Jetty not started, while impact was modified"
              # fi
              sleep 10
              nohup java -cp '/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/lib/*:/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/classes' siren.fenix.covid.services.FenixCovidAPIServer port:2501 logdir:/tmp > /opt/hosting/impact_app_municipalities_published/jetty.log 2>&1 &
              log "Jetty just started on port 2501"
              echo "Sleeping 60 seconds before starting SMS server"
              sleep 60
              nohup java -cp '/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/lib/*:/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/classes' siren.fenix.covid.sms.services.FenixSmsServer port:2600 logdir:/tmp > /opt/hosting/impact_app_municipalities_published/smsjetty.log 2>&1 &
              log "Sms Jetty just started on port 2600"


            fi
         done


}
#if [ -z "$(fuser 2501/tcp)" ]
if [ -z "$(ps aux | egrep 'FenixCovidAPIServer.*2501' | grep -v grep)" ]
then
      log "Jetty not yet started on port 2501. will start"
      nohup java -cp '/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/lib/*:/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/classes' siren.fenix.covid.services.FenixCovidAPIServer port:2501 logdir:/tmp > /opt/hosting/impact_app_municipalities_published/jetty.log 2>&1 &
      log "Jetty just started on port 2501"
else
      log "Jetty already started on port 2501"
fi

echo "Sleeping 60 seconds before starting SMS server"
sleep 60


if [ -z "$(ps aux | egrep 'FenixSmsServer.*2600' | grep -v grep)" ]
then
      log "Sms Jetty not yet started on port 2600. will start"
      nohup java -cp '/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/lib/*:/opt/hosting/impact_app_municipalities_published/ROOT/WEB-INF/classes' siren.fenix.covid.sms.services.FenixSmsServer port:2600 logdir:/tmp > /opt/hosting/impact_app_municipalities_published/smsjetty.log 2>&1 &
      log "Sms Jetty just started on port 2600"
else
      log "Sms Jetty already started on port 2600"
fi


if [ -z "$(ps aux | grep 'inotifywait -m -e create /opt/hosting/impact_app_municipalities_published' | grep -v grep | awk -F ' ' '{print $2}')" ]
then
    log "Started watching for changes in /opt/hosting/impact_app_municipalities_published"
    monitor &
else
      log "Already watching for changes in /opt/hosting/impact_app_municipalities_published"
fi
