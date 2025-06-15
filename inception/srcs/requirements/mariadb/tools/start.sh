#!/bin/bash
set -e

# initialize DB if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[+] Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    echo "[+] Starting MariaDB in bootstrap mode..."
    mysqld --skip-networking --socket=/tmp/mysql.sock &
    pid="$!"

    for i in {30..0}; do
        if mariadb-admin ping --socket=/tmp/mysql.sock --silent; then
            break
        fi
        echo 'Waiting for MariaDB to start...'
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 'MariaDB bootstrap did not start.'
        exit 1
    fi

    echo "[+] Running initialization SQL..."
    mariadb --socket=/tmp/mysql.sock < /tmp/create_wp_db.sql

    echo "[+] Shutting down bootstrap server..."
    mysqladmin --socket=/tmp/mysql.sock shutdown
fi

echo "[+] Starting MariaDB server..."
exec gosu mysql mysqld
