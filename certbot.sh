#!/bin/bash

#Script para renovar certificado SSL zabbix
# Formato dos aquivo
date_format=$(date "+%d-%m-%Y-%H:%M:%S")

# Log do letsencript
log_lets="/var/log/letsencrypt/letsencrypt.log"

# Onde sera enviado arquivo de log
log_file="/var/log/cetbot-renew.log"

 ######################################
####### testes arquivo de log ##########
 ######################################

# Verifica se existe o diretorio para armazenar os logs se nao existir sera criado!
if [ ! -d $log_file ]; then
    touch $log_file
    printf "[$date_format] Arquivo de log checado e criado com sucesso!!\n" >> $log_file
fi

#######################################
######### executar script #############
#######################################

systemctl stop zabbix-server zabbix-agent httpd php-fpm

sleep 5s

certbot renew --force-renewal

sleep 2s

systemctl restart zabbix-server zabbix-agent httpd php-fpm

# Escrevendo arquivo de log para simples conferencia!
echo "[$date_format] \n"  >> $log_file
tail $log_lets >> $log_file
echo "[$date_format] Script para renovar certificado da url exemplo.com.br" >>$log_file

# Remove arquivos de logs antigos -10 dias!
find $log_file -type f -mtime +10 -exec rm -rf {} \;


###### Sintax para renovar certificado de forma manual #####

#certbot certonly --force-renew -d exemplo.com.br
