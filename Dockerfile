ARG LOCAL_PHP=latest
FROM wordpressdevelop/php:${LOCAL_PHP}

ARG LOCAL_PHP

COPY . /var/www

# Set the working directory
WORKDIR /var/www

EXPOSE 80
