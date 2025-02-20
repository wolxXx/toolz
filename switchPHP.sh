#!/usr/bin/env bash

if [ -n "$1" ]; then
  echo "switching to $1";
  echo "";
  echo "current php info:"
  php -v
  echo "";
  echo "";
else
  HERE=$(dirname $(readlink -f $0));
  cd $HERE;
  echo "Version parameter not supplied."
  echo "";
  echo "Usage: $0 <version>"
  echo "$0 5.6"
  echo "$0 6.0"
  echo "$0 7.1"
  echo "$0 7.2"
  echo "$0 7.3"
  echo "$0 7.4"
  echo "$0 8.0"
  echo "$0 8.1"
  echo "$0 8.2"
  echo "$0 8.3"
  echo "$0 8.4"
  echo "";
  echo "";
  
  versions=( "3" "4" "5" "6" "7" "8" );
  for i in "${versions[@]}"
  do
    (ls -h /usr/bin/php$i* | grep php) || echo "no php-$i version detected" 
  done
  
  exit 1;
fi

sudo a2dismod php8.*
sudo a2dismod php7.*
sudo a2dismod php5.*
sudo a2enmod php$1
sudo service apache2 restart
sudo update-alternatives --set php /usr/bin/php$1

echo "validation:"

sudo ls /etc/apache2/mods-enabled | grep php
php -v

exit 0;