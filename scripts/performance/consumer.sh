#!/bin/sh

export BOOTSTRAP_SERVERS=localhost:19092,localhost:29092,localhost:39092

kafka-consumer-perf-test \
  --broker-list ${BOOTSTRAP_SERVERS} \
  --group PERF_TEST \
  --messages 10000000 \
  --threads 2 \
  --show-detailed-stats \
  --reporting-interval 5000 \
  --timeout 5000000 \
  --consumer.config ./consumer_config.properties \
  --topic $1 

#  --group cg-fetch-min 
