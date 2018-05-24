FROM gjchen/php-laravel:php7

ENV	APP="/bookstack" \
	APP_ENV=production

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add git postfix \
	php7-openssl php7-mbstring php7-tokenizer php7-gd php7-mysqlnd php7-tidy php7-simplexml php7-dom \
	php7-fileinfo php7-xmlwriter php7-pdo_mysql php7-ldap && \
	mkdir -p /var/spool/postfix/etc && \
	echo nameserver 8.8.8.8 > /var/spool/postfix/etc/resolv.conf && \
	envsubst '$APP' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && \
	git clone https://github.com/BookStackApp/BookStack.git --branch release --single-branch ${APP} && \
	cp ${APP}/.env.example ${APP}/.env && \
	chown -R nginx:nginx ${APP} && \
	mkdir -p /.composer/cache/files/ && chmod -R 777 /.composer && \
	cd ${APP} && su-exec nginx:nginx composer.phar install && \
	chmod -R a+w ${APP}/storage ${APP}/bootstrap/cache/ ${APP}/public/uploads && \
	su-exec nginx:nginx php artisan key:generate --force

COPY	s6.d /etc/s6.d
	
EXPOSE	80
	