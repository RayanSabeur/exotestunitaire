FROM php:8.1-cli

# Installer les extensions PHP nécessaires
RUN apt-get update && \
    apt-get install -y libzip-dev unzip && \
    docker-php-ext-install mbstring

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY . .

# Installer les dépendances PHP
RUN composer install

# Exécuter les tests PHPUnit
CMD ["./vendor/bin/phpunit"]