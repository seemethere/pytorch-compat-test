ARG BASE
ARG BASE_IMAGE=ubuntu:14.04

FROM ${BASE_IMAGE} as debian-base
RUN apt-get update && apt-get install -y build-essential ninja-build curl

FROM archlinux as arch-base
RUN pacman -Sy --noconfirm base-devel curl ninja

FROM centos:7 as redhat-base
RUN yum install -y centos-release-scl
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum install -y devtoolset-7 curl ninja-build

FROM ${BASE} as dev
RUN curl -fsSL -o install_conda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh install_conda.sh -b -p /opt/conda
ENV PATH /opt/conda/bin:$PATH
RUN conda install -c pytorch-test \
        future \
        hypothesis \
        ninja \
        numpy \
        pillow \
        pytorch \
        pyyaml \
        six
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT '/entrypoint.sh'
