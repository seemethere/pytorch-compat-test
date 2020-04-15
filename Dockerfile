ARG BASE
ARG BASE_IMAGE=ubuntu:14.04

FROM ${BASE_IMAGE} as debian-base
RUN apt-get update && apt-get install -y gcc curl

FROM archlinux as arch-base
RUN pac -Sy gcc curl

FROM centos:7 as redhat-base
RUN yum install -y gcc curl

FROM ${BASE} as dev
RUN curl -fsSL -o install_conda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh install_conda.sh -b -p /opt/conda
ENV PATH /opt/conda/bin:$PATH
RUN conda install -c pytorch-test pytorch scipy tensorflow future hypothesis ninja scipy numpy six
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT '/entrypoint.sh'
