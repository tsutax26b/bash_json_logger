#!/bin/bash

service rsyslog start
td-agent -d /var/run/td-agent/td-agent.pid --group td-agent
tail -f /dev/null