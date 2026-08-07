
# Moira Project Manager

Project manager focused on Scrum.

## Prerequisites

- git ^2.43.0
- docker ^29.7.1
- docker compose ^5.1.4
- build-essential ^12.10

## Dev Environment

Laravel accessible through:
```bash
http://localhost:8000
```

Vue accessible through:
```bash
http://localhost:5173
```

## Build project

First time project setup:
```bash
make setup
```

Bringing containers up:
```bash
make up
```

Bringing containers down:
```bash
make down
```

Restarting containers:
```bash
make restart
```

Running migrations:
```bash
make migrate
```

Fresh migration + seeding:
```bash
make fresh
```

Checking composer logs:
```bash
make logs
```

Opening container shell:
```bash
make CONTAINER_NAME-shell
```