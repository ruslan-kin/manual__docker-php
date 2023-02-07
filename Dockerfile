FROM php:8.1-fpm

RUN pecl install apcu apfd && docker-php-ext-enable apfd

RUN apt-get update && apt-get install -y \
  libicu-dev \
  libzip-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libxml2-dev \
  libpng-dev \
  libxslt-dev \
  libpq-dev \
  git \
  unzip

RUN docker-php-ext-install -j$(nproc) iconv intl xml soap opcache pgsql pdo pdo_pgsql zip xsl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime