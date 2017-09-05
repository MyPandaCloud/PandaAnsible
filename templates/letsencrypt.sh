#!/bin/bash

echo "CERTBOT_DOMAIN : $CERTBOT_DOMAIN"
echo "CERTBOT_VALIDATION : $CERTBOT_VALIDATION"
echo "CERTBOT_TOKEN : $CERTBOT_TOKEN"

nsupdate -k /root/*.key /tmp/nsupdate

exit 0

