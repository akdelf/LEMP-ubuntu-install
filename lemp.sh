#!/usr/bin/env bash

sudo -i

echo -e "upgrade system ...\n"
apt-get update
apt-get -y upgrade



# NGINX

echo -e "install nginx ...\n"
apt-get install -y nginx

#PHP-FPM

echo -e "install php5-fpm ...\n"
apt-get install -y php5-fpm

echo -e "Configure PHP Processor ...\n"
sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini

echo -e "listen port 9000 in php5-fpm ...\n"
sed -i "s/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php5/fpm/pool.d/www.conf


# INSTALL PERCONA

echo -e "add Percona repo ... \n"

apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
echo "deb http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list
echo "deb-src http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list
apt-get update

echo -e "install percona client-server...\n"
apt-get install percona-server-server-5.6 percona-server-client-5.6

echo -e "add root password  - Password1...\n"
mysqladmin -u root password Password1


# INSTALL PHP MODULES

echo -e "install MySQL database connections directly from PHP ...\n"
apt-get install -y php5-mysql

echo -e "install Command-Line Interpreter ...\n"
apt-get install -y php5-cli

echo -e "cURL is a library for getting files from FTP, GOPHER, HTTP server"
apt-get install -y php5-curl


echo -e "open php short_tags... \n"
sed -i "s/short_open_tag = Off/short_open_tag = On/g" /etc/php5/fpm/php.ini 


#Utilites

echo -e "install git ...\n"
apt-get install -y git

echo -e "composer install... \n"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer