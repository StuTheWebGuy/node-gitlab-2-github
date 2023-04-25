CONTAINER_IMAGE ?= node-gitlab-2-github
CONTAINER_TAG ?= latest
LOCAL_PWD = $(shell pwd)

.PHONY: build-image
build-image: ##@docker Build the Docker image
	docker build -t $(CONTAINER_IMAGE):$(CONTAINER_TAG) .

.PHONY: docker-run
docker-run:
	docker run $(CONTAINER_IMAGE):$(CONTAINER_TAG)

.PHONY: docker-run-bind
docker-run-bind:
	docker run \
		--mount type=bind,source="$(LOCAL_PWD)/settings.ts",target="/app/settings.ts",readonly \
		$(CONTAINER_IMAGE):$(CONTAINER_TAG)

.PHONY: use
use: ## Switch settings files
	ln -sf settings.$(NAME).ts settings.ts

.PHONY: run
run: ## Run the script
	npm run start
