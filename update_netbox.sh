#!/bin/bash

vOLD=3.4.
vNew=3.3.10

wget https://github.com/netbox-community/netbox/archive/v$vNew.tar.gz
tar -xzf v$vNew.tar.gz -C /opt
ln -sfn /opt/netbox-$vNew/ /opt/netbox

cp /opt/netbox-$vOLD/local_requirements.txt /opt/netbox/
cp /opt/netbox-$vOLD/netbox/netbox/configuration.py /opt/netbox/netbox/netbox/
cp /opt/netbox-$vOLD/netbox/netbox/ldap_config.py /opt/netbox/netbox/netbox/
mkdir /opt/netbox/local
mkdir /opt/netbox/local/logs
cp /opt/netbox-$vOLD/local/logs/django-ldap-debug.log /opt/netbox/local/logs/

cp -pr /opt/netbox-$vOLD/netbox/media/ /opt/netbox/netbox/
cp -r /opt/netbox-$vOLD/netbox/scripts /opt/netbox/netbox/
cp -r /opt/netbox-$vOLD/netbox/reports /opt/netbox/netbox/
cp /opt/netbox-$vOLD/gunicorn.py /opt/netbox/

chown --recursive netbox:netbox /opt/netbox/

cd /opt/netbox/
./upgrade.sh

## Reiniciando os serviços...

systemctl restart netbox netbox-rq
systemctl status netbox netbox-rq

echo FIM!

exit 0
