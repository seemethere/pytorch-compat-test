BASE_IMAGE ?= ubuntu:14.04
BASE       ?= ubuntu-base

PYTORCH_DIR  = $${HOME}/scratch/pytorch
DOCKER_BUILD = docker build -t compat-test:$@ --build-arg BASE_IMAGE=$(BASE_IMAGE) --build-arg BASE=$(BASE) .
DOCKER_RUN   = docker run --rm -it -v $(PYTORCH_DIR):/pytorch -w /pytorch/test compat-test:$@

.PHONY: ubuntu-14.04
ubuntu-14.04: BASE_IMAGE := ubuntu:14.04
ubuntu-14.04: BASE       := debian-base
ubuntu-14.04:
	$(DOCKER_BUILD)
	$(DOCKER_RUN) | tee $@.log

.PHONY: ubuntu-16.04
ubuntu-16.04: BASE_IMAGE := ubuntu:16.04
ubuntu-16.04: BASE       := debian-base
ubuntu-16.04:
	$(DOCKER_BUILD)
	$(DOCKER_RUN) | tee $@.log

.PHONY: centos-7
centos-7: BASE_IMAGE := centos:7
centos-7: BASE       := redhat-base
centos-7:
	$(DOCKER_BUILD)
	$(DOCKER_RUN) | tee $@.log

.PHONY: archlinux
archlinux: BASE_IMAGE := archlinux
archlinux: BASE       := arch-base
archlinux:
	$(DOCKER_BUILD)
	$(DOCKER_RUN) | tee $@.log
