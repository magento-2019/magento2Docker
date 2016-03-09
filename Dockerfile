FROM ubuntu:15.10

MAINTAINER Mikalai Sahnouski

#RUN apt-get update
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu wily main" | tee -a /etc/apt/sources.list && \
echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu wily main" | tee -a /etc/apt/sources.list && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com
RUN apt-get update
RUN apt-get install -y --force-yes nginx php7.0-fpm
RUN apt-get install -y --force-yes php7.0-mysql curl php7.0-curl php7.0-intl php7.0-common php7.0-cli
RUN apt-get install -y --force-yes php-soap php7.0-gd php7.0-mcrypt sendmail php7.0-xsl php7.0-zip php-zip php7.0-mbstring
RUN apt-get install -y --force-yes vim
RUN apt-get upgrade -y && \
apt-get clean -y

RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer

VOLUME  /var/www
VOLUME  /var/log/magento

RUN composer global require "fxp/composer-asset-plugin:1.1.1"

COPY dockerFiles/nginx /etc/nginx
COPY dockerFiles/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY dockerFiles/run.sh /root/run.sh

RUN chown root:root /etc/nginx -R
RUN chown root:root /etc/php/7.0/fpm/pool.d/www.conf
RUN chown root:root /root/run.sh
RUN chmod +x /root/run.sh

EXPOSE 80

ENTRYPOINT /root/run.sh


