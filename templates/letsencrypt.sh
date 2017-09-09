#!/bin/bash

echo "CERTBOT_DOMAIN : $CERTBOT_DOMAIN"
echo "CERTBOT_VALIDATION : $CERTBOT_VALIDATION"

PUBLICIP=`curl ipinfo.io/ip`

echo "server {{ vault_dns_ip }}" > /tmp/nsupdate
echo "zone mypanda.cloud." >> /tmp/nsupdate
echo "update delete _acme-challenge.$CERTBOT_DOMAIN." >> /tmp/nsupdate
echo "update add _acme-challenge.$CERTBOT_DOMAIN. 60 IN TXT $CERTBOT_VALIDATION" >> /tmp/nsupdate
echo "update add {{ FQDN }}. 600 IN A $PUBLICIP"  >> /tmp/nsupdate
echo "update add emby.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "update add ampache.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "update add homeassistant.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "update add nextcloud.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "update add transmission.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "update add zoneminder.{{ FQDN }} 600 IN CNAME {{ FQDN }}"  >> /tmp/nsupdate
echo "send" >> /tmp/nsupdate

nsupdate -k /root/*.private -v /tmp/nsupdate > /tmp/letsencrypt.log 2>&1

sleep 10

exit 0

