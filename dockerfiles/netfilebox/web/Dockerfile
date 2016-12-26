FROM netfilebox_basedb_client
MAINTAINER Paul S. Russo  "paul.russo@netfilebox.com"

# Install Nginx and PHP.
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y install sudo nginx php5-gd php5-common php5-mysql php5-curl php5-intl php5-mcrypt php5-imagick php-apc php5-apcu php5-cgi php5-fpm php5-cli expect && chown -R www-data:www-data /var/lib/nginx

RUN groupadd -g 5000 vmail && useradd -u 5000 -g vmail vmail && usermod -a -G vmail www-data

RUN rm /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/sites-available/default

COPY ./dockerfiles/start.sh/ /
COPY ./dockerfiles/opt/ /opt/
COPY ./dockerfiles/etc/ /etc/

CMD []
ENTRYPOINT ["/start.sh"]
