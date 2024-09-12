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

# Copier le fichier composer.json et installer les dépendances
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copier le code source et les tests
COPY src/ src/
COPY phpunittest/ phpunittest/

# Installer PHPUnit
RUN composer require --dev phpunit/phpunit

# Commande pour exécuter les tests
CMD ["vendor/bin/phpunit", "--testdox"]