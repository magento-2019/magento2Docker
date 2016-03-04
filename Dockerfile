FROM ubuntu:15.10

MAINTAINER Mikalai Sahnouski

RUN apt-get update
RUN apt-get install -y nginx php5-fpm
RUN apt-get install -y php5-mysql curl php5-curl php5-intl php5-common php5-cli 
RUN apt-get install -y php-soap php5-gd php5-mcrypt sendmail php5-xsl
RUN apt-get install -y vim
RUN apt-get upgrade -y && \
apt-get clean -y
RUN php5enmod mcrypt
#RUN apt-get install -y php5-gd

RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer

#----
VOLUME  /var/www
#COPY dockerFiles/magento2 /var/www
VOLUME  /var/log/magento

#RUN cd /var/www && \
#composer global require "fxp/composer-asset-plugin:1.1.1"

COPY dockerFiles/nginx /etc/nginx
COPY dockerFiles/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf
COPY dockerFiles/fpm/php.ini /etc/php5/fpm/php.ini
COPY dockerFiles/fpm/php.ini /etc/php5/cli/php.ini
COPY dockerFiles/run.sh /root/run.sh

RUN chown root:root /etc/nginx -R
RUN chown root:root /etc/php5/fpm/pool.d/www.conf
RUN chown root:root /root/run.sh
RUN chmod +x /root/run.sh

EXPOSE 80

ENTRYPOINT /root/run.sh
#----
#RUN chmod -R 777 /var/www/frontend/assets/
#RUN chmod -R 777 /var/www/frontend/runtime
#RUN chmod -R 777 /var/www/frontend/web/assets
#
#RUN chmod -R 777 /var/www/backend/assets/
#RUN chmod -R 777 /var/www/backend/runtime
#RUN chmod -R 777 /var/www/backend/web/assets


