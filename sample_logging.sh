#!/usr/bi/bash
source ./json_logger.sh
export PATH=$PATH:/opt/td-agent/bin

raise(){
    exit 1
}

json_logging "This is an DEBUG level log." --severity="DEBUG"
json_logging "This is an INFO level log." --severity="INFO"
json_logging "This is an WARNING level log." --severity="WARNING"
json_logging "This is an ERROR level log." --severity="ERROR"
json_logging "This is an CRITICAL level log." --severity="CRITICAL"

json_logging "This is an INFO level log." --severity="INFO" --log-filepath="./YYYYMMDD.log"

MSG=$(json_logging "If no log level is specified, INFO-level logs are output.")
(   
    # try
    echo $MSG | fluent-cat batch.log --retry-limit 2 || raise
) || {
    # catch
    echo $MSG | logger -t batch.log
}