FROM netfilebox_baseos
MAINTAINER Paul S. Russo  "paul.russo@netfilebox.com"
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y install mysql-server
COPY ./dockerfiles/check_db.sh /usr/local/bin/
COPY ./dockerfiles/my.cnf /etc/mysql/
COPY ./dockerfiles/start.sh /
COPY ./dockerfiles/sql/ /opt/sql/
CMD []
ENTRYPOINT ["/start.sh"]
EXPOSE 3306
