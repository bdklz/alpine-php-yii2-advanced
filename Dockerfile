FROM geekidea/alpine-a:3.10
# FROM alpine:3.10
MAINTAINER Etopian Inc. <contact@etopian.com>

ENV TIMEZONE            Asia/Shanghai


RUN apk update && \
  apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
  apk add \
    openssl \
    ca-certificates \
    curl \
    bash \
    bash-completion \
    ncurses \
    vim \
    gettext \
    logrotate \
    tar \
    rsync \
    shadow \
    s6 \
    nginx \
    mailcap \
    php7.1-apcu \
    php7.1-dev \
    php7.1-bcmath \
    php7.1-fpm \
    php7.1-ctype \
    php7.1-curl \
    php7.1-dom \
    php7.1-gd \
    php7.1-gettext \
    php7.1-gmp \
    php7.1-iconv \
    php7.1-intl \
    php7.1-tokenizer \
    php7.1-fileinfo \
    php7.1-xmlwriter \
    php7.1-json \
    php7.1-mcrypt \
    php7.1-mysqli \
    php7.1-openssl \
    php7.1-opcache \
    php7.1-pdo \
    php7.1-pdo_mysql \
    php7.1-pear \
    php7.1-pgsql \
    php7.1-phar \
    php7.1-mcrypt \ 
    php7.1-exif \
    php7.1-xmlreader \
    php7.1-sqlite3 \
    php7.1-xml \
    php7.1-xsl \
    php7.1-dom \
    php7.1-sockets \
    php7.1-zip \
    php7.1-dev \
    php7.1-mbstring \
    php7.1-session \
    php7.1-apcu \
    php7.1-simplexml \
    autoconf \
    build-base \
    libsodium-dev \
    git \
    dcron \
    php7.1-zlib \
    # && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    # gnu-libiconv \
    && rm -rf \
      /var/cache/apk/* && \
    rm -rf \
      /etc/nginx/* && \
  mkdir /etc/logrotate.docker.d

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

ENV TERM=xterm PHP_MEMORY_LIMIT=512M PHP_POST_MAX_SIZE=2G PHP_UPLOAD_MAX_FILESIZE=2G PHP_MAX_EXECUTION_TIME=3600 PHP_MAX_INPUT_TIME=3600 PHP_DATE_TIMEZONE=PRC PHP_LOG_LEVEL=warning PHP_MAX_CHILDREN=75 PHP_MAX_REQUESTS=500 PHP_PROCESS_IDLE_TIMEOUT=10s NGINX_WORKER_PROCESSES=5 NGINX_WORKER_CONNECTIONS=4096 NGINX_SENDFILE=on NGINX_TCP_NOPUSH=on LOGSTASH_ENABLED=false  HOST_FRONT=frontend.localhost HOST_BACK=backend.localhost DB_NAME=user DB_USER=user DB_PASS=pass DB_PORT=3306 DB_HOST=172.17.0.1 REDIS_HOST=172.17.0.1 REDIS_PORT=6379 REDIS_DB=0

ADD rootfs /

COPY nginx.conf /etc/nginx/nginx.conf
COPY yii2nginx.conf /etc/nginx/presets/default.conf
COPY setup /etc/s6/nginx/setup


RUN  sed -ie 's/-n//g' /usr/bin/pecl && pecl channel-update pecl.php.net && pecl install libsodium && pecl install redis && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/bin --filename=composer && composer global require hirak/prestissimo



EXPOSE 80

WORKDIR /app
CMD ["/bin/s6-svscan", "/etc/s6"]
