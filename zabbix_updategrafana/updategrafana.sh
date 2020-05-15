#!/bin/bash
VERSAOGRAFANA=$(grafana-server -v | awk -F " " {'print $2'})
curl -s 'https://grafana.com/grafana/download' | grep grafana_"$VERSAOGRAFANA"_amd64.deb > /dev/null
echo $?
