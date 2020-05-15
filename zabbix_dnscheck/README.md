Script e Template Zabbix para monitoramento de DNS Publico.

Script na parte de discovery, faz por LLD a criação dos itens com base nos dados no arquivo listadns.txt.
O discovery retorna o JSON no padrão do Zabbix para o funcionamento do LLD.

Disponibilizado template para o Zabbix.

O "dig" deve estar instalado no servidor que realizará as checagens.
