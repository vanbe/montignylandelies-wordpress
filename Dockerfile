FROM php:8.2-fpm-alpine

# Extensions PHP requises par WordPress (+ imagick recommandé)
# Base php:8.2-fpm-alpine inclut déjà : curl, dom, fileinfo, json, mbstring,
# openssl, SimpleXML, sodium, xml, xmlreader, xmlwriter, Zend OPcache, zlib
RUN apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        icu-dev \
        libxml2-dev \
        imagemagick-dev \
        imagemagick \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        mysqli \
        gd \
        zip \
        exif \
        intl \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# OPcache (déjà chargé, on ajuste juste les valeurs)
RUN echo "opcache.enable=1\nopcache.memory_consumption=128\nopcache.max_accelerated_files=10000\nopcache.revalidate_freq=2" \
    > /usr/local/etc/php/conf.d/opcache.ini
