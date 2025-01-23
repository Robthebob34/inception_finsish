FROM debian:bullseye

#this exposes the port only to the other docker containers, but not to host
EXPOSE 3306

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/create_user.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

# Fix permissions for /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mysqld_safe"]

# test if you can connect to maridb database
# sudo docker exec -it mariadb mariadb --user tblaase -proot
# SHOW DATABASES;
# USE wordpress;
# SHOW TABLES
