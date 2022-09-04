FROM ubuntu:18.04
WORKDIR /usr/batch
RUN apt-get update && apt-get install -y curl rsyslog jq
RUN curl -o /usr/batch/td-agent-apt-source.deb \
    https://packages.treasuredata.com/4/ubuntu/bionic/pool/contrib/f/fluentd-apt-source/fluentd-apt-source_2020.8.25-1_all.deb && \
    apt-get install -y /usr/batch/td-agent-apt-source.deb
RUN apt-get update && apt-get install -y td-agent

