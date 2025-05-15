NAME := inception

# Colors
RESET=$(shell echo -e "\033[0m")
BLUE=$(shell echo -e "\033[1;34m")
YELLOW=$(shell echo -e "\033[1;33m")
RED=$(shell echo -e "\033[1;31m")
GREEN=$(shell echo -e "\033[1;32m")

DOCKER_COMPOSE_YML := srcs/docker-compose.yml
DOCKER_VOL_MARIADB := mariadb_vol
DOCKER_VOL_WP := wp_vol

DATA_DIR := $(HOME)/data
DATA_DIR_MARIADB := $(DATA_DIR)/mariadb
DATA_DIR_WP := $(DATA_DIR)/wp

all: $(NAME)

$(NAME): $(DATA_DIR_MARIADB) $(DATA_DIR_WP)
	@echo "$(BLUE)Creating data directories...$(RESET)"
	@echo "$(GREEN)Data directories created at $(DATA_DIR)$(RESET)"
	@docker compose -p $(NAME) -f $(DOCKER_COMPOSE_YML) up --build
	touch $(NAME)

$(DATA_DIR_MARIADB):
	@mkdir -p $@

$(DATA_DIR_WP):
	@mkdir -p $@

up: $(NAME)

down:
	@docker compose -p $(NAME) -f $(DOCKER_COMPOSE_YML) down

clean:
	@docker compose -p $(NAME) down --rmi all -v

fclean: clean
	@echo "$(YELLOW)Removing data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN) Removing all unused Docker resources...$(RESET)"
	rm -f $(NAME)

re: fclean $(NAME)

.PHONY: all up down clean fclean re
