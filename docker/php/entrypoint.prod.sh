#!/bin/sh

set -eu

cd /var/www/html

mkdir -p \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache

#cache prod config
php artisan config:cache
php artisan route:cache
php artisan view:cache

exec "$@"