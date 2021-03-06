FROM php:7.1-fpm
MAINTAINER Ivan Kalinichenko <kalinichenko@constlab.ru>

ARG INSTALL_NODEJS=true
ARG INSTALL_ENVOY=true

# Install soft
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libicu-dev \
    git \
    subversion \
    zip \
    unzip \
    wget \
    nano \
    openssh-client \
    build-essential \
    mysql-client \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install intl mbstring gd mysqli pdo_mysql opcache zip

RUN pecl install apcu && docker-php-ext-enable apcu

ARG PUID=1000
ARG PGID=1000

RUN usermod -u 1000 www-data

# Install composer
COPY install-composer /install-composer
RUN /install-composer && rm /install-composer

# Install wp cli
COPY install-wp-cli /install-wp-cli
RUN /install-wp-cli && rm /install-wp-cli

# Install nodejs and gulp cli
RUN if [ ${INSTALL_NODEJS} = true ];  then \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs && \
    npm install gulp-cli -g && \
    mkdir /var/www/.config && \
    chown -R www-data:www-data /var/www/.config && \
    npm install npm -g \
;fi

COPY ./composer.json /var/www/.composer/composer.json
RUN chown -R www-data:www-data /var/www/.composer

RUN touch /var/www/.bashrc && chown -R www-data:www-data /var/www/.bashrc
USER www-data
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc

# Install envoy
RUN if [ ${INSTALL_ENVOY} = true ];  then \
    composer global require "laravel/envoy=~1.0" \
;fi

# Clean up
USER root
RUN apt-get clean && \
    apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

CMD ["php-fpm"]

EXPOSE 9000
