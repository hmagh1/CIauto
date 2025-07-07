FROM php:8.1-apache

# Installer les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Installer Xdebug pour la couverture
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Activer mod_rewrite (optionnel pour futur REST)
RUN a2enmod rewrite

# Copier les fichiers de l'application dans le dossier public d'Apache
COPY public/ /var/www/html/
COPY src/ /var/www/html/src/
COPY vendor/ /var/www/html/vendor/
COPY composer.json composer.lock phpunit.xml /var/www/html/

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer Composer si nécessaire
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
