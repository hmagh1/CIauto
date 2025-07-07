FROM php:8.1-apache

# Installer les extensions PHP requises
RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Installer Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Activer mod_rewrite (utile pour futur routing)
RUN a2enmod rewrite

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Copier uniquement les fichiers nécessaires pour composer install
COPY composer.json /var/www/html/
WORKDIR /var/www/html
RUN composer install

# Copier le reste du code
COPY public/ /var/www/html/
COPY src/ /var/www/html/src/
COPY phpunit.xml /var/www/html/
