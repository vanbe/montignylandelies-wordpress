FROM php:8.2-fpm-alpine

# Extensions PHP requises par WordPress
RUN apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        icu-dev \
        oniguruma-dev \
        libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        mysqli \
        gd \
        zip \
        exif \
        intl \
        mbstring \
        opcache \
        xml

# OPcache recommandé pour WordPress
RUN echo "opcache.enable=1\nopcache.memory_consumption=128\nopcache.max_accelerated_files=10000\nopcache.revalidate_freq=2" \
    > /usr/local/etc/php/conf.d/opcache.ini
