#!/bin/bash

if ! [ -d /var/www/html/vendor/laravel ]; then
    cd /var/www/html
    composer install
    cp /var/www/html/.env.sample /var/www/html/.env
    php /var/www/html/artisan key:generate
fi

chown -R www-data /var/www/html

sed -i -e "s/<YOUR_COMPUTER_IP>/$YOUR_COMPUTER_IP/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

php-fpm -F -c /etc/php/8.4/fpm/php.ini -y /etc/php/8.4/fpm/php-fpm.conf

