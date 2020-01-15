# Yii2 Advanced Nginx PHP7 PHP-FPM

## Modules

redis
libsodium

Pecl is fixed so if you need to install additional modules you can use pecl.

Can use with multiple sites using our proxy container

https://github.com/etopian/nginx-proxy

Use this to enable SSL with our proxy container:

https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion


Example on how to deploy using our Nginx proxy container and the let's encrypt proxy companion:

docker run -d --name=$CONTAINER_NAME -e "LETSENCRYPT_HOST=domain1.etopian.com,domain2.etopian.com" -e "LETSENCRYPT_EMAIL=contact@mydomain.com" -e VIRTUAL_HOST=domain1.etopian.com,domain2.etopian.com -eYII_DEBUG=$YII_DEBUG -eYII_ENV=$YII_ENV -e HOST_FRONT=domain1.etopian.com -e HOST_BACK=domain2.etopian.com -v /data/sites/etopian.com/htdocs:/app etopian/alpine-php-yii2-advanced:latest

## Volumes

* /app


## Ports

* 80


## Available environment variables

```bash
ENV PHP_MEMORY_LIMIT 512M
ENV PHP_POST_MAX_SIZE 2G
ENV PHP_UPLOAD_MAX_FILESIZE 2G
ENV PHP_MAX_EXECUTION_TIME 3600
ENV PHP_MAX_INPUT_TIME 3600
ENV PHP_DATE_TIMEZONE UTC
ENV PHP_LOG_LEVEL warning
ENV PHP_MAX_CHILDREN 75
ENV PHP_MAX_REQUESTS 500
ENV PHP_PROCESS_IDLE_TIMEOUT 10s
```


## Inherited environment variables

```bash
ENV NGINX_WORKER_PROCESSES 5
ENV NGINX_WORKER_CONNECTIONS 4096
ENV NGINX_SENDFILE on
ENV NGINX_TCP_NOPUSH on
```

```bash
ENV LOGSTASH_ENABLED false
ENV LOGSTASH_HOST logstash
ENV LOGSTASH_PORT 5043
ENV LOGSTASH_CA /etc/ssl/logstash/certs/ca.pem # As string or filename
ENV LOGSTASH_CERT /etc/ssl/logstash/certs/cert.pem # As string or filename
ENV LOGSTASH_KEY /etc/ssl/logstash/private/cert.pem # As string or filename
ENV LOGSTASH_TIMEOUT 15
ENV LOGSTASH_OPTS
```


## Contributing

Fork -> Patch -> Push -> Pull Request


## Authors
* [ChinaPHP](https://github.com/chinaphp)
* [Etopian Inc](https://github.com/etopian)
* [Thomas Boerger](https://github.com/tboerger)
* [Christoph Wiechert](https://github.com/psi-4ward)


## License

MIT


## Copyright

```
Copyright (c) 2016-2017 Etopian Inc <https://www.etopian.com>
Copyright (c) 2015-2016 Thomas Boerger <http://www.webhippie.de>
```
