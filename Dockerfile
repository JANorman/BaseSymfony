FROM janorman/nginx-php-fpm:latest

RUN apt-get update && \
    apt-get install -y curl php5-dev php-pear autoconf g++ make openssl libssl-dev libcurl4-openssl-dev libcurl4-openssl-dev pkg-config

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN mkdir /home/var && mkdir /home/var/logs && mkdir /home/var/cache &&  mkdir /home/var/sessions && chmod -R 777 /home/var/
ADD build/default.conf /etc/nginx/sites-available/default.conf

ADD . /home/app/web
RUN cd /home/app/web && composer install --prefer-dist