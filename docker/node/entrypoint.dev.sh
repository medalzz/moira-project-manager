#!/bin/sh

set -e

cd /var/www/frontend

exec npm run dev -- --host 0.0.0.0