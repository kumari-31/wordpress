FROM wordpress:6.4-php8.2-apache

# Copy your local WordPress files (plugins, themes, etc.) into the image
COPY src/wp-content/themes/twentytwentyfour/ /var/www/html/wp-content/themes/twentytwentyfour/

# Fix permissions so the web server user (www-data) can read/write
RUN chown -R www-data:www-data /var/www/html/wp-content/themes/twentytwentyfour/ \
    && find /var/www/html/wp-content/themes/twentytwentyfour/ -type d -exec chmod 755 {} \; \
    && find /var/www/html/wp-content/themes/twentytwentyfour/ -type f -exec chmod 644 {} \;

EXPOSE 80
