Monitoramento de Certificados Digitais.

Inserir os scripts .py no /usr/lib/zabbix/externalscripts
(Baixar os scripts em: https://github.com/wjesus374/https_getcert)

Configurar os UserParameters:

UserParameter=get_ssl,/usr/lib/zabbix/externalscripts/get_ssl_info.py
UserParameter=read[*],/usr/lib/zabbix/externalscripts/read.py $1 $2

Verificar as Macros, para definir o melhor tempo para as triggers

Disponibilizado também Dashboard para Grafana.
