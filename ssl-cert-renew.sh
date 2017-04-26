#!/bin/bash
#
# Get the current date as seconds since epoch.
NOW=$(date +%s)
#
# Get the expiry date of our certificates.
EXPIRE_DOKUWIKI=$(openssl x509 -in /etc/letsencrypt/live/wiki.moxli.io/fullchain.pem -noout -enddate)
#
# Trim the unecessary text at the start of the string.
EXPIRE_DOKUWIKI=${EXPIRE_DOKUWIKI#*=}
#
# Convert the expiry date to seconds since epoch.
EXPIRE_DOKUWIKI=$(date --date="$EXPIRE_DOKUWIKI" +%s)
#
# Calculate the time left until the certificate expires.
LIFE_DOKUWIKI=$((EXPIRE_DOKUWIKI-NOW))
echo "$LIFE_DOKUWIKI"
#
# The remaining life on our certificate below which we should renew (7 days).
RENEW=604800
#
# If the certificate has less life remaining than we want.
if ((LIFE_DOKUWIKI < RENEW))
        then
                # Renew the certificate.
                certbot --apache certonly -n -d wiki.moxli.io
                # You could also execute "certbot renew" to renew all certificates found on the system
fi
