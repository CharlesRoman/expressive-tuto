.EXPORT_ALL_VARIABLES:
UID := $(shell id -u)

COMPOSER=$(APP) composer
YARN=$(APP) yarn
DOCKER_COMPOSE?=docker-compose
DOCKER_COMPOSE_OPTIONS=--remove-orphans
APP=$(DOCKER_COMPOSE) run --rm app
CYAN=\033[36m
END=\033[0m
BOLD=\033[1m

.PHONY: setup build start stop restart

.env: ## Create the .env file according to .env.example
	@cp .env.template .env && printf "Created $(CYAN).env$(END) file\n"

setup: .env clean-app

setup-git: clean-git git-start

clean-app:
	@rm -rf sources/app/.gitkeep && printf "$(CYAN).gitkeep$(END) removed from $(CYAN)sources/app$(END) directory\n"

clean-git:
	@rm -rf .git/ && printf "$(CYAN).git/$(END) directory removed\n"

git-start:
	@git init && printf "$(CYAN)GIT$(END) repository initialized\n"
	@git add .
	@git commit -m 'Initial commit' && printf "First commit with message 'Initial commit'\n"

install-symfo: setup build create-symfo

install-zend-xp: setup build create-zend-xp

install-api-platform-vue: setup build create-api-platform-vue

build:
	@printf "\n\n$(BOLD)BUILDING $(CYAN)DOCKER$(END)$(BOLD) CONTAINERS$(END)\n"
	@$(DOCKER_COMPOSE) up -d
	@printf "$(BOLD)$(CYAN)DOCKER$(END)$(BOLD) CONTAINERS READY !$(END)\n"


create-symfo: symfo-website webpack-encore

create-zend-xp: zend-xp-base

create-api-platform-vue: symfo-base symfo-api webpack-encore webpack-vue

symfo-website:
	@printf "\n\n$(BOLD)CREATING A $(CYAN)SYMFONY$(END)$(BOLD) WEBSITE SKELETON$(END)\n"
	@$(COMPOSER) create-project symfony/website-skeleton .
	@$(COMPOSER) require symfony/apache-pack
	@printf "$(BOLD)$(CYAN)SYMFONY$(END)$(BOLD) WEBSITE SKELETON CREATED !$(END)\n"

symfo-base:
	@printf "\n\n$(BOLD)CREATING A $(CYAN)SYMFONY$(END) $(BOLD)SKELETON$(END)\n"
	@$(COMPOSER) create-project symfony/skeleton .
	@printf "$(BOLD)$(CYAN)SYMFONY$(END) $(BOLD)SKELETON CREATED SUCCESSFULLY !$(END)\n"

symfo-api:
	@printf "\n\n$(BOLD)INSTALLING $(CYAN)API PLATFORM$(END)\n"
	@$(COMPOSER) req api
	@printf "$(BOLD)$(CYAN)API PLATFORM$(END)$(BOLD) INSTALLED SUCCESSFULLY !$(END)\n"

webpack-encore:
	@printf "\n\n$(BOLD)INSTALLING $(CYAN)WEBPACK ENCORE$(END)$(BOLD) FOR $(CYAN)SYMFONY$(END)\n"
	@$(COMPOSER) require symfony/webpack-encore-bundle
	@$(YARN) install
	@printf "$(BOLD)$(CYAN)WEBPACK ENCORE$(END)$(BOLD) FOR $(CYAN)SYMFONY$(END)$(BOLD) INSTALLED SUCCESSFULLY !$(END)\n"

webpack-vue: webpack-encore adding-vue

adding-vue:
	@printf "\n\n$(BOLD)ADDING $(CYAN)VUE JS $(END)$(BOLD)TO $(CYAN)WEBPACK ENCORE$(END)\n"
	@$(YARN) add vue
	@$(YARN) add --dev vue-loader vue-template-compiler @babel/plugin-transform-runtime @babel/runtime
	@printf "$(BOLD)$(CYAN)VUE JS$(END)$(BOLD) ADDED SUCCESSFULLY TO $(CYAN)WEBPACK ENCORE$(END)\n"

zend-xp-base:
	@printf "\n\n$(BOLD)CREATING A $(CYAN)ZEND EXPRESSIVE$(END)$(BOLD) SKELETON $(END)\n"
	@$(COMPOSER) create-project zendframework/zend-expressive-skeleton .
	@printf "$(BOLD)$(CYAN)ZEND EXPRESSIVE$(END)$(BOLD) SKELETON CREATED SUCCESSFULLY !$(END)\n"

start:
	@$(DOCKER_COMvPOSE) up -d $(DOCKER_COMPOSE_OPTIONS)

stop:
	@$(DOCKER_COMPOSE) down $(DOCKER_COMPOSE_OPTIONS)

restart: stop start
