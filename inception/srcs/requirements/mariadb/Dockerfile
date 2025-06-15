# use a debian image as a base image
FROM debian:bookworm

# install mariadb server
RUN apt-get -y update && \
    apt-get -y install mariadb-server wget && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu

# include the sql init file for initializing the database
COPY tools/create_wp_db.sql /tmp/
COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

ENTRYPOINT ["/start.sh"]