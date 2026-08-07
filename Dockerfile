ARG PHP_VERSION=8.5.9
ARG NGINX_VERSION=1.31.3

# --------------------------------------------------
# PHP
# --------------------------------------------------
FROM php:${PHP_VERSION}-fpm-alpine AS php

ARG PHP_REDIS_VERSION=6.3.0
ARG PHP_SWOOLE_VERSION=5.3.4

# install general php dependencies
RUN apk add --no-cache \
    zip \
    unzip \
    curl \
    ca-certificates \
    nano \
    bind-tools \
    icu-libs \
    libpq \
    libzip \
    oniguruma \
    libpng \
    libxml2

# install php build dependencies & php extensions
RUN apk add --no-cache --virtual .php-build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        libpq-dev \
        libzip-dev \
        oniguruma-dev \
        libpng-dev \
        libxml2-dev \
    && docker-php-ext-install \
        zip \
        intl \
        mbstring \
        pgsql \
        pdo_pgsql \
        simplexml \
        xml \
        pcntl \
        gd

# install redis
RUN pecl install redis-${PHP_REDIS_VERSION} \
    && docker-php-ext-enable redis

# # install swoole
# RUN pecl install swoole-${PHP_SWOOLE_VERSION} \
#     && docker-php-ext-enable swoole

#delete php build dependencies
RUN apk del .php-build-deps

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# clean tmp files
RUN rm -rf /tmp/* /var/tmp/*

# set working directory
WORKDIR /var/www/html

CMD ["php-fpm"]

# --------------------------------------------------
# Nginx
# --------------------------------------------------
FROM nginx:${NGINX_VERSION}-alpine AS nginx

# COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
# COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html