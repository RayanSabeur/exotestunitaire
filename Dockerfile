# Utiliser une image PHP officielle comme image de base
FROM php:8.1-cli

# Installer les extensions nécessaires et les outils
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    git \
    unzip \
    && docker-php-ext-install xml \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le code source
COPY . .

# Copier le fichier composer.json et installer les dépendances
RUN composer install --no-dev --optimize-autoloader

# Installer PHPUnit
RUN composer require --dev phpunit/phpunit

# Exécuter les tests
CMD ["vendor/bin/phpunit"]