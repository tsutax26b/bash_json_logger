#!/bin/bash
json_logging() {
    # default
    SEVERITY="INFO"
    MESSAGE="$1"
    LOG_FILEPATH=""
    # options
    while (( $# > 0))
    do 
        case $1 in
            --severity=*)
                if [[ "$1" =~ ^--severity=(DEBUG|INFO|NOTICE|WARNING|ERROR|CRITICAL)$ ]]; then
                    SEVERITY=$(echo $1 | sed -e 's/^--severity=//')
                fi
                ;;
            --log-filepath=*)
                if [[ "$1" =~ ^--log-filepath= ]]; then
                    LOG_FILEPATH=$(echo $1 | sed -e 's/^--log-filepath=//')
                    LOG_FILEPATH=$(cd $(dirname $LOG_FILEPATH) && pwd)/$(basename $LOG_FILEPATH)
                fi
                ;;
        esac
        shift
    done
    # get time
    now=`date +"%s,%N"`
    ARR=(${now//,/ })
    SECONDS=${ARR[0]}
    NANOS=${ARR[1]}
    # create payload
    echo '{}' | jq -n -c  \
        --arg severity "$SEVERITY" \
        --arg message "$MESSAGE" \
        --arg log_filepath "$LOG_FILEPATH" \
        --arg hostname "$HOSTNAME" \
        --arg pid "${$}" \
        --arg seconds "$SECONDS" \
        --arg nanos "$NANOS" \
        '{
            severity: $severity,
            message: $message,
            timestamp: {
                seconds: ($seconds|tonumber),
                nanos: ($nanos|tonumber)
            },
            "logging.googleapis.com/labels":{
                hostname:$hostname,
                pid:$pid,
                log_filepath:$log_filepath
            }
        }'
}