# export BUILDKIT_PROGRESS=plain << debug

# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php
NODE_CONT = $(DOCKER_COMP) exec node


# Executables
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer
SYMFONY  = $(PHP_CONT) bin/console
NPM		 = $(NODE_CONT) npm
YARN	 = $(NODE_CONT) yarn

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc migrate fixture test testDetail

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the PHP FPM container
	@$(PHP_CONT) sh

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf

## —— Yarn / Npm / Webpack ❤❤❤ ———————————————————————————————————————————————————————————————
yarn: ## Run yarn, pass the parameter "c=" to run a given command, example: make composer c='yarn add package'
	@$(eval c ?=)
	@$(YARN) $(c)

npm: ## Run npm, pass the parameter "c=" to run a given command, example: make composer c='npm add package'
	@$(eval c ?=)
	@$(NPM) $(c)

yarn/install: ## Run Yarn Install
yarn/install: c=install
yarn/install: yarn

yarn/build: ## Run Yarn Build
yarn/build: c=build
yarn/build: yarn


## —— Unit Tests 🔥❤  ———————————————————————————————————————————————————————————————
colon := :
$(colon) := :

migrate: c='doctrine$(:)migrations$(:)migrate' --env=test --no-interaction
migrate: sf

fixture: c='doctrine$(:)fixtures$(:)load' --env=test --no-interaction
fixture: sf

test: ## composer test
	@$(MAKE) migrate || true
	@$(MAKE) fixture || true
	@$(COMPOSER) test

testDetail: ## Launch Tests Details
	@$(MAKE) migrate || true
	@$(MAKE) fixture || true
	@$(COMPOSER) testDetail
