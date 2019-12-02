#!/bin/sh

if [ $# -lt 1 ]; then
  echo "usage: $0 topic [partitions]"
  echo "\tpartitions default 10"
  exit
fi

ZOOKEEPER=localhost:2181

P=10

if [ $# -ge 2 ]; then
  P=$2 
fi

echo "creating $1 with $P partitions."

kafka-topics \
  --zookeeper ${ZOOKEEPER} \
  --create \
  --partitions $P \
  --replication-factor 3 \
  --config \
     min.insync.replicas=2 \
  --topic $1
