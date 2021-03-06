#
# PHPSChool.io
# A revolutionary new way to learn PHP.
# Bring your imagination to life in an open learning eco-system.
#

FROM php:7-cli
MAINTAINER Rafael Corrêa Gomes <rafaelcg_stz@hotmail.com>


RUN apt-get update \
  && apt-get install -y \
    apt-utils \
    zip \
    git \
    vim \
    libzip-dev \
    zlib1g-dev \
  && docker-php-ext-configure zip --with-zlib-dir=/usr \
  && docker-php-ext-install -j$(nproc) zip 

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /phpschool

# Learn You PHP!
RUN mkdir /phpschool/learnyouphp \
    && cd /phpschool/learnyouphp \
    && composer init -q -n \
    && composer require php-school/learn-you-php

# Callable Functions
RUN mkdir /phpschool/callablefunctions \
    && cd /phpschool/callablefunctions \
    && composer init -q -n \
    && composer require nastasia/callable-functions

# Workshop manager 
RUN mkdir /phpschool/workshop-manager \
    && cd /phpschool/workshop-manager \
    && curl -O https://php-school.github.io/workshop-manager/workshop-manager.phar \
    && mv workshop-manager.phar /usr/local/bin/workshop-manager \
    && chmod +x /usr/local/bin/workshop-manager 

WORKDIR /phpschool




CMD ["php", "-a"]