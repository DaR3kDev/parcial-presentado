# Imagen base con Apache + PHP 8.2
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Copiar el proyecto al contenedor
COPY ./src /var/www/html/

# Configuración de Apache para permitir .htaccess
RUN echo "<Directory /var/www/html/> \n\
    Options Indexes FollowSymLinks \n\
    AllowOverride All \n\
    Require all granted \n\
    </Directory>" > /etc/apache2/conf-available/app.conf \
    && a2enconf app

# Dar permisos a Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exponer puerto Apache
EXPOSE 80
