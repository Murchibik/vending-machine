-include .env
export $(shell sed 's/=.*//' .env)

.DEFAULT_GOAL := help

dc := docker-compose -p $(APP_SLUG)
dr := $(dc) run --rm
de := $(dc) exec
det := $(dc) exec -T

.PHONY: help
help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
build-clean: ## BUILD: Optional - Clean docker
	@printf "$$BGreen Stop rm prune and purge all containers $$ColorOff \n"
	docker stop $$(docker ps -a -q) && docker rm $$(docker ps -a -q);\
	docker system prune --volumes --force --all && docker images purge

.PHONY: build
build-construct: ## BUILD: Step2 - Build app containers
	@printf "$$BGreen Build containers (time for a coffee break ☕ !) $$ColorOff \n"
	$(dc) up -d --build

.PHONY: up
up: ## CONTAINER: Start application
	$(dc) up -d

.PHONY: down
down: ## CONTAINER: Stop application
	$(dc) down

.PHONY: execute
execute: ## CONTAINER: Exec command in docker
	$(de) $(command)