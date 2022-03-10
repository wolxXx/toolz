# toolz
### used by me at ubuntu server - maybe you need it, too :) 

# Table of contents
[update helper](#update)<br>
[switch PHP version](#switch)<br>
[fix PHP ini settings](#fixphp)<br>
[lxc to hosts](#lxc2hosts)<br>


## grab update.sh - a wrapper for apt-based linuxes for updating the system <a name="update"></a>
- runs apt update, apt dist-upgrade and removes unused packages at once
- `wget https://raw.githubusercontent.com/wolxXx/toolz/main/update.sh`
- `chmod +x update.sh`
- `./update.sh`
- one-line: `wget https://raw.githubusercontent.com/wolxXx/toolz/main/update.sh && chmod +x update.sh && ./update.sh`

## grab switchPHP.sh - a tool for easily switching the PHP version, if installed <a name="switch"></a>
- easily disables all possible installed apache modules
- enables the selected version as apache module and path variable
- `wget https://raw.githubusercontent.com/wolxXx/toolz/main/switchPHP.sh`
- `chmod +x switchPHP.sh`
- `./switchPHP.sh` -> lists all possible php versions
- `./switchPHP.sh 7.4` -> enables version 7.4
- `./switchPHP.sh 8.0` -> enables version 8.0
- interested on how to install multiple PHP versions at your computer? check https://launchpad.net/~ondrej/+archive/ubuntu/php 
  - sudo apt install software-properties-common -y
  - sudo add-apt-repository -muy ppa:ondrej/php
  - sudo add-apt-repository -muy ppa:ondrej/apache2
  - sudo apt update
  - sudo apt dist-upgrade -y
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php7.1 php7.1-bcmath php7.1-cli php7.1-curl php7.1-dev php7.1-gd php7.1-imap php7.1-intl php7.1-json php7.1-mbstring php7.1-mysql php7.1-opcache php7.1-readline php7.1-soap php7.1-tidy php7.1-xml php7.1-xsl php7.1-zip php-xdebug php-imagick unzip
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php7.2 php7.2-bcmath php7.2-cli php7.2-curl php7.2-dev php7.2-gd php7.2-imap php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php-xdebug php-imagick unzip
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php7.3 php7.3-bcmath php7.3-cli php7.3-curl php7.3-dev php7.3-gd php7.3-imap php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php7.3-soap php7.3-tidy php7.3-xml php7.3-xsl php7.3-zip php-xdebug php-imagick unzip
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php7.4 php7.4-bcmath php7.4-cli php7.4-curl php7.4-dev php7.4-gd php7.4-imap php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-readline php7.4-soap php7.4-tidy php7.4-xml php7.4-xsl php7.4-zip php-xdebug php-imagick unzip
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php8.0 php8.0-bcmath php8.0-cli php8.0-curl php8.0-dev php8.0-gd php8.0-imap php8.0-intl php8.0-mbstring php8.0-mysql php8.0-opcache php8.0-readline php8.0-soap php8.0-tidy php8.0-xml php8.0-xsl php8.0-zip php-xdebug php-imagick unzip
    - sudo apt install apache2 apache2-dev apache2-utils apachetop mysql-server mysql-client mytop mycli php8.1 php8.1-bcmath php8.1-cli php8.1-curl php8.1-dev php8.1-gd php8.1-imap php8.1-intl php8.1-mbstring php8.1-mysql php8.1-opcache php8.1-readline php8.1-soap php8.1-tidy php8.1-xml php8.1-xsl php8.1-zip php-xdebug php-imagick unzip


## grab fixPHP.sh - a tool for easily setting php.ini files for local development <a name="fixphp"></a>
- setting php ini variables
  - enable short_open_tags
  - setting output_buffering to on 
  - setting memory_limit to 4G
  - enable whole error_reporting E_ALL
  - always display_errors
  - do display_startup_errors
  - do log_errors
  - allow 4G post_max_size
  - set upload_max_filesize to 4G
  - do allow_url_include
  - setting date.timezone to "Europe/Berlin"
- `wget https://raw.githubusercontent.com/wolxXx/toolz/main/fixPHP.sh`
- `chmod +x fixPHP.sh`
- `./fixPHP.sh`
- one-line: `wget https://raw.githubusercontent.com/wolxXx/toolz/main/fixPHP.sh && chmod +x fixPHP.sh && ./fixPHP.sh`

## grab lxc2hosts.sh - a tool for easily setting /etc/hosts mapping for lxc containers <a name="lxc2hosts"></a>
- detects the ip address from each lxc container
- writes them with the name of the container into /etc/hosts 
- easy ssh into with `ssh user@my-lxc-container` without checking the ip address every time
- needs super user rights to execute (sudo)
- needs jq dependency installed
  - jq allows you to read and evaluate json via bash
  - `apt install jq` is your friend here 
- be aware that running the script twice, the written content is doubled
  - edit /etc/hosts file before running the script again
  - the new contents are seperated by `######` - 100dd does the trick  
- `wget https://raw.githubusercontent.com/wolxXx/toolz/main/lxc2hosts.sh`
- `chmod +x lxc2hosts.sh`
- `./lxc2hosts.sh`
- one-line: `wget https://raw.githubusercontent.com/wolxXx/toolz/main/lxc2hosts.sh && chmod +x lxc2hosts.sh && ./lxc2hosts.sh`
