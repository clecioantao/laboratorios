#!/bin/bash
while :
do
	curl http://192.168.0.100:5005
	sleep $((RANDOM % 300 ))
done
