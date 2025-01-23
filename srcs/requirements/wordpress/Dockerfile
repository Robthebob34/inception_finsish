FROM debian:bullseye

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	curl && \
	rm -rf /var/lib/apt/lists/*

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz

RUN cd /var/www && tar -xvf latest.tar.gz && \
	rm -rf latest.tar.gz && \
	chown -R www-data:www-data /var/www/wordpress

RUN mkdir -p /run/php && \
	chown www-data:www-data /run/php

COPY ./conf/config.sh /var/www/wordpress/config.sh
RUN chmod +x /var/www/wordpress/config.sh

WORKDIR /var/www/wordpress

CMD ["/var/www/wordpress/config.sh"]
