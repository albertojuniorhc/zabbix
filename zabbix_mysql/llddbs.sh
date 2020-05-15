#!/bin/bash

# Baseado no script de Rodrigo Lang, justado por Alberto Jr para MySQL
# Utilizando .my.cnf em /etc/zabbix

lines=$(HOME=/etc/zabbix mysql -e 'show databases' | grep -v Database | grep -v information_schema | grep -v performance_schema | wc -l)
loop=1

inicio="{\"data\":["

for i in $(HOME=/etc/zabbix mysql -e 'show databases' | grep -v Database | grep -v information_schema | grep -v performance_schema); do

    loop=$(($loop+1))

    if [ "$loop" -gt "$lines" ]; then
        data=${data}"{\"{#DBNAME}\":\"$i\"}"
    else
        data=${data}"{\"{#DBNAME}\":\"$i\"},"
    fi


done

final="]}"
echo $inicio$data$final
