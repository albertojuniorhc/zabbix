#!/bin/bash
# Criado por Alberto Jr - https://github.com/albertojuniorhc/zabbix_dnscheck
# Discovery - Retorna JSON no padrao do Zabbix para criacao dos itens
# Check - Retorna o tempo da resposta. Se nao houver resposta, retorna 999. Tratamento de dados no Zabbix e Grafana.

localarquivos="/usr/lib/zabbix/externalscripts"

case $1 in

        discovery)
                inicio="{\"data\":["
                i=1
                DNS=$(cat $localarquivos/listadns.txt | grep -v \#)
                lines=$(cat $localarquivos/listadns.txt | grep -v \# | wc -l)
                for dns in $DNS; do
                        i=$(($i+1))
                        if [ "$i" -gt "$lines" ]; then
                                data=${data}"{\"{#DNS}\":\"$(echo $dns | cut -f 1 -d ',')\","
                                data=${data}"\"{#NOME}\":\"$(echo $dns | cut -f 2 -d ',')\"}"
                        else
                                data=${data}"{\"{#DNS}\":\"$(echo $dns | cut -f 1 -d ',')\","
                                data=${data}"\"{#NOME}\":\"$(echo $dns | cut -f 2 -d ',')\"},"
                        fi

                done

                final="]}"
                echo $inicio$data$final
                ;;

        check)
                RESPOSTA=$(dig +timeout=2 +tries=1 @$2 | grep "Query time: ")
                if [ $? != "0" ]; then
                        RESPOSTA=999
                else
                        RESPOSTA=$(echo $RESPOSTA | cut -f 2 -d ':' | cut -f 2 -d ' ')
                fi
                echo $RESPOSTA
esac
