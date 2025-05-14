# Colors
RESET=$(shell echo -e "\033[0m")
BLUE=$(shell echo -e "\033[1;34m")
YELLOW=$(shell echo -e "\033[1;33m")
RED=$(shell echo -e "\033[1;31m")
GREEN=$(shell echo -e "\033[1;32m")

NAME := inception
# Paths
# DATA_DIR=home/jlu/data
DATA_DIR := $(HOME)/data
DATA_DIR_MARIADB := $(DATA_DIR)/mariadb
DATA_DIR_WP := $(DATA_DIR)/wordpress

# Docker compose file
COMPOSE := srcs/docker-compose.yml

# Commands
.PHONY: all up down clean fclean re

all: $(NAME)

$(NAME): $(DATA_DIR_MARIADB) $(DATA_DIR_WP)
	@echo "$(BLUE)Creating data directories...$(RESET)"
	@echo "$(GREEN)Data directories created at $(DATA_DIR)$(RESET)"
	cd srcs && docker compose up --build -d
	touch $(NAME)

$(DATA_DIR_MARIADB):
	@mkdir -p $@

$(DATA_DIR_WP):
	@mkdir -p $@

up: $(NAME)

down:
	cd srcs && docker compose down

clean:
	docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@echo "$(YELLOW)Removing data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN) Removing all unused Docker resources...$(RESET)"
	docker system prune -f --volumes
	rm -f $(NAME)

re: fclean all