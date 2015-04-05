IMAGE_NAME ?= makepkg-arch
DOCKER ?= docker

.PHONY: container-build
container-build: $(dist_FILE)
	$(DOCKER) run --rm --volume "$(CURDIR):/data" $(IMAGE_NAME)

.PHONY: container-dist
container-dist: $(dist_FILE)
	$(DOCKER) run --rm --volume "$(CURDIR):/data" $(IMAGE_NAME) --source

.PHONY: pkg-clean
pkg-clean:
	-$(RM) *.pkg.tar.xz
	-$(RM) *.src.tar.gz

.PHONY: src-clean
src-clean:
	$(RM) example

.PHONY: clean
clean: pkg-clean src-clean
