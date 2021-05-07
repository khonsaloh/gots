#!/bin/sh

while true; do
	grc netstat -tulnap 2>/dev/null
	sleep 5
	printf "\\n"
done 

