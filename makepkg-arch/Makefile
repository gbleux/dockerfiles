DOCKER ?= docker

IMAGE_NAME := makepkg-arch

.PHONY: default
default: docker-image

.PHONY: docker-image
docker-image:
	@$(DOCKER) build -t $(IMAGE_NAME) $(CURDIR)

.PHONY: example-pkg
example-pkg:
	$(MAKE) -C example IMAGE_NAME=$(IMAGE_NAME) container-build

.PHONY: example-src
example-src:
	$(MAKE) -C example IMAGE_NAME=$(IMAGE_NAME) container-dist

.PHONY: docker-clean
docker-clean:
	@$(DOCKER) rmi $(IMAGE_NAME)

.PHONY: clean
clean:
	$(MAKE) -C example clean
