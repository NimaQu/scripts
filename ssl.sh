#!/bin/bash
usage="Usage: `basename $0` (init|renew|getcert|getkey|setcron) domain_name"
command=$1
domain=$2
filetemp="/etc/nginx/ssl/temp"
sslloc=/etc/nginx/ssl
httpuser="NimaQu"
basepath=$(cd `dirname $0`; pwd)

function init() {
if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	echo "downloading cert..."
	wget -P $filetemp https://ssl.nimaqu.com/cert/$domain.crt
	mv $filetemp/$domain.crt $sslloc
	echo "downloading key..."
	wget -P $filetemp --http-user=$httpuser --ask-password https://ssl.nimaqu.com/key/$domain.key
	mv $filetemp/$domain.key $sslloc
	echo "result:"
	ls $sslloc/$domain*
	(crontab -l; echo "0 0 */1 * * $basepath/ssl.sh renew $domain > /dev/null")|awk '!x[$0]++'|crontab -
fi
}

function renew() {
if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	wget -P $filetemp https://ssl.nimaqu.com/cert/$domain.crt
	mv $filetemp/$domain.crt $sslloc
	nginx -s reload
fi
}

function getcert() {
if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	wget -P $filetemp https://ssl.nimaqu.com/cert/$domain.crt
	mv $filetemp/$domain.crt $sslloc
fi
}

function getkey() {
if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	wget -P $filetemp --http-user=$httpuser --ask-password https://ssl.nimaqu.com/key/$domain.key
	mv $filetemp/$domain.key $sslloc
fi
}

function setcron() {
if [ ! -n "$domain" ] ;then
    echo "Please input domain name"
else
	(crontab -l; echo "0 0 */1 * * $basepath/ssl.sh renew $domain > /dev/null")|awk '!x[$0]++'|crontab -
fi
}

case $command in
	(init)
		init
     ;;
	(renew)
		renew
     ;;
	(getcert)
		getcert
     ;;
	(getkey)
		getkey
     ;;
	(setcron)
		setcron
     ;;
	(*)
		echo "Error command"
		echo "$usage"
     ;;
esac