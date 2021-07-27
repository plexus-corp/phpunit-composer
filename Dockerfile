ARG COMPOSER_IMAGE_TAG=2
ARG BASE_IMAGE_TAG=7.2-apache

FROM php:${BASE_IMAGE_TAG} AS php-prep-stage
LABEL maintainer="mike.tallroth@plexus.com"

# Prep php and copy composer executable in from docker hub image
COPY --from=composer:${COMPOSER_IMAGE_TAG} /usr/bin/composer /usr/bin/composer
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libicu-dev \
    unzip \
  && docker-php-ext-install -j$(nproc) \
    intl
