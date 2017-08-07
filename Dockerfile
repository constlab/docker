FROM php:7.0-fpm
MAINTAINER Ivan Kalinichenko <kalinichenko@constlab.ru>

# Install soft
RUN apt-get update && apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    libicu-dev \
    git \
    subversion \
    zip \
    unzip \
    wget \
    openssh-client \
    build-essential \
    mysql-client \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install intl mbstring gd mysqli pdo_mysql opcache zip \
	&& apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

RUN pecl install apcu && docker-php-ext-enable apcu

# Install composer
COPY install-composer /install-composer
RUN /install-composer && rm /install-composer

# Install wp cli
COPY install-wp-cli /install-wp-cli
RUN /install-wp-cli && rm /install-wp-cli

ARG PUID=1000
ARG PGID=1000
RUN groupadd -g ${PGID} constlab && useradd -u ${PUID} -g constlab -m constlab

WORKDIR /var/www/html

CMD ["php-fpm"]

EXPOSE 9000