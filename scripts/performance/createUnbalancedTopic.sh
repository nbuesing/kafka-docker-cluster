#!/bin/bash

ZK=localhost:2181

if [ $# -lt 1 ]; then
  echo "usage: $0 topic"
  exit
fi

# creates a 6 partition topic with no replicas on broker 3

kafka-topics \
  --zookeeper $ZK \
  --create \
  --topic $1 \
  --config \
    min.insync.replicas=2 \
  --replica-assignment 1:2,2:1,1:2,2:1,1:2,2:1
