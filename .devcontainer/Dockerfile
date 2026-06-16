FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    valgrind \
    man-db \
    manpages-dev \
    git \
    curl \
    zsh \
    && rm -rf /var/lib/apt/lists/*

RUN yes | unminimize