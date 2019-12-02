#!/bin/sh

export BOOTSTRAP_SERVERS=localhost:19092,localhost:29092,localhost:39092

if [ "$1" == "" ]; then 
  echo "usage: $0 topic"
  exit -1
fi


kafka-producer-perf-test \
  --num-records 100000 \
  --record-size 1000 \
  --throughput 1000 \
  --producer-props \
    bootstrap.servers=${BOOTSTRAP_SERVERS} \
    acks=all \
    request.timeout.ms=60000 \
    retries=2147483647 \
  --print-metrics \
  --topic $1
