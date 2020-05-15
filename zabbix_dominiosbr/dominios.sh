#!/bin/bash
# Criado por Alberto Jr. 
# Discovery - Esquema para montagem do JSON no padrão do Zabbix, para descoberta dos domínios. Os domínios devem estar no arquivo listadominios.txt no local indicado na variável "localarquivos, e com as permissões necessárias"
# Consulta - Esquema para adicionar a chave SecondsToExpire no JSON que retorna do Registro.BR, para utilizarmos em segundos e criar os alertas necessários no Zabbix). Finalizado a adição da chave no JSON, e imprimindo o JSON completo do Registro.BR, junto com a chave de Segundos.

localarquivos="/usr/lib/zabbix/externalscripts"

case $1 in

        discovery)
                inicio="{\"data\":["
                i=1
                DOMINIOS=$(cat $localarquivos/listadominios.txt | grep -v \#)
                lines=$(cat $localarquivos/listadominios.txt | grep -v \# | wc -l)
                for dominios in $DOMINIOS; do
                        i=$(($i+1))
                        if [ "$i" -gt "$lines" ]; then
                                data=${data}"{\"{#DOMINIO}\":\"$dominios\"}"
                        else
                                data=${data}"{\"{#DOMINIO}\":\"$dominios\"},"
                        fi

                done

                final="]}"
                echo $inicio$data$final
                ;;

        consulta)
                jsonregbr=$(curl -s 'https://registro.br/v2/ajax/whois/?qr='$2'')
                expireat=$(date +%s -ud $(echo $jsonregbr | jq -r .Domain.ExpiresAt))
                today=$(date +%s)
                result=$(( $expireat - $today ))
                #
                echo $(echo $jsonregbr | jq '.Domain |= . + {"SecondsToExpire" : "'$result'" }')

esac
