#!/bin/sh
IP_ZABBIX=127.0.0.1
HOST=Monitoramento
UPDATES=$(sudo apt-get -s upgrade | grep Inst | wc -l)

/usr/bin/zabbix_sender -z $IP_ZABBIX -s "$HOST" -k updates.quantidade -o $UPDATES
