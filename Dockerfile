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
    php7-apcu-7.1.5-r0 \
    php7-dev-7.1.5-r0 \
    php7-bcmath-7.1.5-r0 \
    php7-fpm-7.1.5-r0 \
    php7-ctype-7.1.5-r0 \
    php7-curl-7.1.5-r0 \
    php7-dom-7.1.5-r0 \
    php7-gd-7.1.5-r0 \
    php7-gettext-7.1.5-r0 \
    php7-gmp-7.1.5-r0 \
    php7-iconv-7.1.5-r0 \
    php7-intl-7.1.5-r0 \
    php7-tokenizer-7.1.5-r0 \
    php7-fileinfo-7.1.5-r0 \
    php7-xmlwriter-7.1.5-r0 \
    php7-json-7.1.5-r0 \
    php7-mcrypt-7.1.5-r0 \
    php7-mysqli-7.1.5-r0 \
    php7-openssl-7.1.5-r0 \
    php7-opcache-7.1.5-r0 \
    php7-pdo-7.1.5-r0 \
    php7-pdo_mysql-7.1.5-r0 \
    php7-pear-7.1.5-r0 \
    php7-pgsql-7.1.5-r0 \
    php7-phar-7.1.5-r0 \
    php7-mcrypt -7.1.5-r0\ 
    php7-exif-7.1.5-r0 \
    php7-xmlreader-7.1.5-r0 \
    php7-sqlite3-7.1.5-r0 \
    php7-xml-7.1.5-r0 \
    php7-xsl-7.1.5-r0 \
    php7-dom-7.1.5-r0 \
    php7-sockets-7.1.5-r0 \
    php7-zip-7.1.5-r0 \
    php7-dev-7.1.5-r0 \
    php7-mbstring-7.1.5-r0 \
    php7-session-7.1.5-r0 \
    php7-apcu-7.1.5-r0 \
    php7-simplexml-7.1.5-r0 \
    autoconf \
    build-base \
    libsodium-dev \
    git \
    dcron \
    php7-zlib-7.1.5-r0 \
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
