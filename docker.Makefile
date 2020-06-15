BASE_IMAGE  ?= ubuntu:14.04
BASE        ?= ubuntu-base
PYTORCH_REF ?= master

DOCKER_BUILD = docker build -t compat-test:$@ --build-arg BASE_IMAGE=$(BASE_IMAGE) --build-arg BASE=$(BASE) --build-arg PYTORCH_REF=$(PYTORCH_REF) .
DOCKER_RUN   = docker run --rm -it -w /pytorch/test compat-test:$@

.PHONY: ubuntu-16.04
ubuntu-16.04: BASE_IMAGE := ubuntu:16.04
ubuntu-16.04: BASE       := debian-base
ubuntu-16.04:
	$(DOCKER_BUILD)
	$(DOCKER_RUN) | tee $@.log

.PHONY: ubuntu-18.04
ubuntu-18.04: BASE_IMAGE := ubuntu:18.04
ubuntu-18.04: BASE       := debian-base
ubuntu-18.04:
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
