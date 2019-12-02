#!/bin/bash

if [ $# -ne 1 ]; then
  echo "usage: $0 broker_id"
  exit
fi

if ! [[ $1 =~ ^-?[1-9]+[0-9]*$ ]]; then
  echo "broker_id is not a positive integer"
  exit
fi

typeset -i id
id=$1
shift

BROKER="localhost:${id}7072"

#command jq
#[ $? -eq 1 ] && echo "make sure jq is installed and on your PATH" && exit


DOMAIN=kafka.server
TYPE=ReplicaManager
NAME=UnderReplicatedPartitions
PAYLOAD="{\"type\":\"read\",\"mbean\":\"${DOMAIN}:type=${TYPE},name=${NAME}\"}"

#NAME=PartitionCount


curl -s \
    -X POST \
    http://${BROKER}/jolokia/  \
    -d $PAYLOAD \
    | jq -r '.value.Value'


