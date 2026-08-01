#!/bin/sh

set -e

cd /var/www/backend

if [ ! -f composer.json ]; then
    echo "backend/composer.json was not found."
    exit 1
fi

if [ ! -f .env ] && [ -f .env.example ]; then
    echo "Creating backend/.env from .env.example..."
    cp .env.example .env
fi

echo "Installing Composer dependencies..."
composer install \
    --no-interaction \
    --prefer-dist

echo "Running database migrations..."
php artisan migrate

if [ -f artisan ]; then
    if ! grep -q '^APP_KEY=base64:' .env 2>/dev/null; then
        echo "Generating Laravel application key..."
        php artisan key:generate --force
    fi

    php artisan optimize:clear
fi

exec "$@"