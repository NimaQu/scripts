#!/bin/bash

webroot=/var/www/ssl
domain=$1

if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	/root/.acme.sh/acme.sh --install-cert -d $domain --key-file $webroot/key/$domain.key  --fullchain-file $webroot/cert/$domain.crt --reloadcmd     "chmod 644 $webroot/key/*"
fi