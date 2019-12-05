#!/bin/bash


kafka-reassign-partitions \
	--zookeeper localhost:2181 \
	--reassignment-json-file reassignment.json \
	--execute

kafka-reassign-partitions \
	--zookeeper localhost:2181 \
	--reassignment-json-file reassignment.json \
	--verify

