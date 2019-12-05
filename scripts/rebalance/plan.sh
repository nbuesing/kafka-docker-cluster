#!/bin/bash

TOPIC=$1
shift


cat > foo.json <<EOF
{
  "topics": [
    {
      "topic": "${TOPIC}"
    }
  ],
  "version":1
}
EOF


kafka-reassign-partitions \
	--zookeeper localhost:2181 \
	--broker-list "1,2,3,4" \
	--topics-to-move-json-file foo.json \
	--generate \
	| sed -n '5,5p' | jq > reassignment.json

#	| jq > reassignment.json


