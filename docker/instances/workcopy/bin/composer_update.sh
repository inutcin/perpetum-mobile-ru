#!/bin/bash

export COMPOSER_MEMORY_LIMIT=-1     
cd /var/www/html
php -d memory_limit=-1 /usr/local/bin/composer update

