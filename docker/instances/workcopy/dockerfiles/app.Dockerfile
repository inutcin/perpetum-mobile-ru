FROM php:8.4-fpm

MAINTAINER davojan

RUN \
    apt-get update && apt-get install -y \
        libpq-dev \
        libmemcached-dev \
        curl \
        wget \
        mc \
        sudo \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        libzip-dev \
        zip \
        tzdata \
        bzip2 \
        libzip-dev \
        libbz2-dev \
        libxml2-dev \
        git \
        supervisor \
        procps \
        imagemagick \
        libmagickwand-dev \
        graphviz \
        cron \
        libwebp-dev \
        ffmpeg \
        redis-tools \
        --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && unlink /etc/localtime \                                     
    && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN \
    docker-php-ext-configure gd \
        --with-webp \
        --with-jpeg \
        --with-freetype
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install xhprof \
    && docker-php-ext-enable xhprof \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug
RUN \
    docker-php-ext-install \
        pgsql \
        pdo \
        pdo_pgsql \
        opcache \
        zip \
        bz2 \
        soap \
        xml \
        zip \
        bcmath \
        sockets \
        gd

##### Start Memcached
RUN \
    apt-get update \
    && apt-get install -y \
        libmemcached11 \
        libmemcachedutil2 \
        build-essential \
        libmemcached-dev \
        libz-dev \
    && pecl install memcached \ #-3.1.5 \
    && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
##### End memcached


COPY ./docker/instances/workcopy/etc/php /etc/php
COPY ./docker/instances/workcopy/etc/php/8.4/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY ./docker/instances/workcopy/etc/timezone /etc/timezone
COPY ./engine /var/www/html
COPY ./docker/instances/workcopy/bin/app.sh /app.sh
COPY ./docker/instances/workcopy/bin/composer_update.sh /composer_update.sh


ARG HOST_UID
RUN usermod -u ${HOST_UID} www-data

RUN export COMPOSER_MEMORY_LIMIT=-1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -d memory_limit=-1 composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');" 
RUN  usermod -s /bin/bash www-data 
RUN cd /var/www/html
RUN composer install
RUN chown -R www-data: /var/www 
RUN chmod +x /app.sh
