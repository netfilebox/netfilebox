FROM netfilebox_baseos
MAINTAINER Paul S. Russo  "paul.russo@netfilebox.com"
ARG NEXTCLOUD_VERSION=11.0.0

RUN apt-get -y install cifs-utils smbclient
RUN mkdir -p /opt/www && cd /opt/www && \
wget https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.zip && \
unzip /opt/www/nextcloud-$NEXTCLOUD_VERSION.zip && \
rm /opt/www/nextcloud-$NEXTCLOUD_VERSION.zip
RUN chown www-data:www-data /opt/www/nextcloud -R
COPY ./dockerfiles/start.sh /
COPY ./dockerfiles/opt/ /opt/
RUN chmod 755 /opt/nextcloud/bin/*.*

CMD []
VOLUME ["/opt/www/nextcloud"]
ENTRYPOINT ["/start.sh"]
