#!/bin/bash

#
# Start with:
#    docker run --rm -it -p 8080:80 -v $PWD/start.docker.sh:/start ubuntu:xenial /start
#

set -e

trap exit\ 0 INT

echo
echo "This is a setup script that tries to do as much automatically, within a Docker container"
echo

debconf-set-selections <<< 'mysql-server mysql-server/root_password password p@ssw0rd'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password p@ssw0rd'

apt-get update
apt-get install -y apache2 mysql-server php php-mysqli php-gd libapache2-mod-php wget unzip

cd /var/www
wget https://github.com/ethicalhack3r/DVWA/archive/master.zip
unzip master.zip
mv DVWA-master html/dvwa
cd html/dvwa
cp config/config.inc.php.dist config/config.inc.php

chgrp www-data config hackable/uploads external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
chmod g+w config hackable/uploads external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sed -i 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.0/apache2/php.ini

apachectl -D foreground

# bug
mkdir /var/run/mysqld
chown mysql:mysql /var/run/mysqld

mysqld_safe
