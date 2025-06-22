NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env

up: 
	$(COMPOSE) up -d --build

up-not-detached:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

re: fclean up

fclean:
	$(COMPOSE) down --volumes --remove-orphans
	docker system prune -f

nuke_db:
	@echo "[!] WARNING: This will permanently delete your DB bind-mounted files!"
	@echo "[+] Reading DB_VOLUME_PATH from .env..."
	@export DB_VOLUME_PATH=$$(grep DB_VOLUME_PATH srcs/.env | cut -d '=' -f2) && \
	if [ -z "$$DB_VOLUME_PATH" ]; then \
		echo "DB_VOLUME_PATH is not set in .env"; \
		exit 1; \
	fi && \
	echo "[+] Deleting: $$DB_VOLUME_PATH" && \
	rm -rf "$$DB_VOLUME_PATH" && \
	echo "Nuke complete. Database volume directory deleted."