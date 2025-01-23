#!/bin/bash

# Initialize MySQL data directory if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Ensure correct permissions
chown -R mysql:mysql /var/lib/mysql
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld

# Start MySQL in background
mysqld_safe &

# Wait for MySQL to be ready
for i in {30..0}; do
    if mysqladmin ping >/dev/null 2>&1; then
        break
    fi
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress; \
         CREATE USER IF NOT EXISTS 'rheck'@'%' IDENTIFIED BY 'root'; \
         GRANT ALL PRIVILEGES ON wordpress.* TO 'rheck'@'%'; \
         FLUSH PRIVILEGES;"

# Stop MySQL
mysqladmin shutdown

# Start MySQL in foreground
exec mysqld_safe