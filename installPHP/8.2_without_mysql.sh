#!/usr/bin/env bash

function checkRoot() {
  ME=$(whoami)
  if [ ! "root" == $ME ]; then
    echo "you must be root!"
    echo "you are $ME. you rock, sure, but root rocks more ;)"
    echo ""
    exit 1
  fi
}

checkRoot

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:ondrej/apache2
sudo apt dist-upgrade -y
sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-client mycli php8.2 php8.2-bcmath php8.2-cli php8.2-curl php8.2-dev php8.2-gd php8.2-imap php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-soap php8.2-tidy php8.2-xml php8.2-xsl php8.2-zip php-xdebug php-imagick unzip