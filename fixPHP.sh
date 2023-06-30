#!/usr/bin/env bash

versions=( "5.3" "5.4" "5.5" "5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.0" "8.1" "8.2" "8.3" )

for i in "${versions[@]}"
do

    files=( "/etc/php/$i/apache2/php.ini" "/etc/php/$i/cli/php.ini" )

    for FILE in "${files[@]}"
    do
        if test -f "$FILE"; then
            echo "fixing $FILE";
            sed -i '/short_open_tag/c\short_open_tag = On' "$FILE"
            sed -i '/output_buffering/c\output_buffering = On' "$FILE"
            sed -i '/memory_limit/c\memory_limit = 4G' "$FILE"
            sed -i '/error_reporting/c\error_reporting = E_ALL' "$FILE"
            sed -i '/display_errors/c\display_errors = On' "$FILE"
            sed -i '/display_startup_errors/c\display_startup_errors = On' "$FILE"
            sed -i '/log_errors/c\log_errors = On' "$FILE"
            sed -i '/post_max_size/c\post_max_size = 4G' "$FILE"
            sed -i '/upload_max_filesize/c\upload_max_filesize = 4G' "$FILE"
            sed -i '/allow_url_include/c\allow_url_include = On' "$FILE"
            sed -i '/date.timezone/c\date.timezone = "Europe/Berlin"' "$FILE"

        fi
    done
done
