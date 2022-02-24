ifeq ($(UNAME),Darwin)
	SHELL := /opt/local/bin/bash
	OS_X  := true
else ifneq (,$(wildcard /etc/redhat-release))
	OS_RHEL := true
else
	OS_DEB  := true
	SHELL := /bin/bash
endif


ifneq (,$(wildcard ./.env))
include .env
export
else
include .env.template
export
endif

ifndef PROJECT_ID
override PROJECT_ID=$$(basename `git rev-parse --show-toplevel`)
endif

ifndef IS_LOCAL
override IS_LOCAL=True
endif

.EXPORT_ALL_VARIABLES:


## ==
.PHONY: help
help: ## Prints help for targets with comments.
	@cat $(MAKEFILE_LIST) \
		| grep -E '^[a-zA-Z_-]+:.*?## .*$$' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

## ==

.PHONY: build
build: Dockerfile docker-compose.yml ## Build docker images.
	[ ! -f .env ] && cp .env.template .env || true;
	docker-compose -p "$(PROJECT_ID)" build

.PHONY: start
start: ## Start Containers. 
	docker-compose \
	-p $(PROJECT_NAME) \
	-f docker-compose.yml up \
	--remove-orphans --build

.PHONY: stop
stop: ## Stop containers.
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml down \
	--remove-orphans

.PHONY: restart
restart: ## Restart containers.
	make stop && make start

.PHONY: attach
attach: ## Attach to docker-compose services eg.. make attach DC=django
	docker exec -it \
	$(shell docker ps -f name="$(PROJECT_NAME)_$(DC)" --format "{{.ID}}") bash