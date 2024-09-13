FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    git \
    unzip \
    && docker-php-ext-install xml \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN composer require --dev phpunit/phpunit

CMD ["vendor/bin/phpunit"]