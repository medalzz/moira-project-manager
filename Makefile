.PHONY: setup up down restart logs php-shell node-shell pg-shell nginx-shell redis-shell migrate fresh

USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

setup:
	@echo "Setting up the project..."

	@if [ ! -f composer.json ]; then \
		echo "Error: composer.json was not found in the project root."; \
		exit 1; \
	fi

	@if [ ! -f artisan ]; then \
		echo "Error: artisan was not found in the project root."; \
		exit 1; \
	fi

	@if [ ! -f package.json ]; then \
		echo "Error: package.json was not found."; \
		exit 1; \
	fi

	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "Created .env from .env.example"; \
	else \
		echo ".env already exists"; \
	fi

	@echo "Building containers..."
	docker compose build

	@echo "Preparing Laravel writable directories..."
	docker compose run --rm --no-deps \
		--user root \
		--entrypoint sh \
		php -c 'mkdir -p storage/framework/cache/data storage/framework/sessions storage/framework/views storage/logs bootstrap/cache && chmod -R a+rwX storage bootstrap/cache'

	@echo "Installing PHP dependencies..."
	docker compose run --rm --no-deps \
		--user "$(USER_ID):$(GROUP_ID)" \
		--entrypoint composer \
		php install --no-interaction --prefer-dist

	@echo "Installing Vue dependencies..."
	docker compose run --rm --no-deps \
		--user "$(USER_ID):$(GROUP_ID)" \
		--entrypoint npm \
		node install

	@echo "Starting containers..."
	docker compose up -d

	@if ! grep -q '^APP_KEY=base64:' .env 2>/dev/null; then \
		echo "Generating Laravel application key..."; \
		docker compose exec php php artisan key:generate --force; \
	else \
		echo "Application key already exists."; \
	fi

	@echo "Running database migrations..."
	docker compose exec php php artisan migrate --force

	@echo "Clearing caches..."
	docker compose exec php php artisan optimize:clear

	@echo "Setup complete."

up:
	docker compose up -d --build

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

php-sh:
	docker compose exec php sh

node-sh:
	docker compose exec node sh

pg-sh:
	docker compose exec db sh

nginx-sh:
	docker compose exec nginx sh

redis-sh:
	docker compose exec redis sh

migrate:
	docker compose exec php php artisan migrate

seed:
	docker compose exec php php artisan db:seed

fresh:
	docker compose exec php php artisan migrate:fresh --seed
