FROM gjchen/php7:laravel-base

ENV	APP="/bookstack" \
	APP_ENV=production

RUN	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get -y autoremove && apt-get -y autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	mkdir -p /var/spool/postfix/etc && \
	echo nameserver 8.8.8.8 > /var/spool/postfix/etc/resolv.conf && \
	git clone https://github.com/BookStackApp/BookStack.git --branch release --single-branch ${APP} && \
	cp ${APP}/.env.example ${APP}/.env && \
	chown -R nginx:nginx ${APP} && \
	mkdir -p /.composer/cache/files/ && chmod -R 777 /.composer && \
	cd ${APP} && sudo -E -u nginx -g nginx composer.phar install && \
	chmod -R a+w ${APP}/storage ${APP}/bootstrap/cache/ ${APP}/public/uploads && \
	sudo -E -u nginx -g nginx php artisan key:generate --force

COPY	s6.d /etc/s6.d
	
EXPOSE	80
	