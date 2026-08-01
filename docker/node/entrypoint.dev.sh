#!/bin/sh

set -e

cd /var/www/frontend

if [ ! -f package.json ]; then
    echo "frontend/package.json was not found."
    exit 1
fi

echo "Installing frontend dependencies..."
npm install

exec npm run dev -- --host 0.0.0.0