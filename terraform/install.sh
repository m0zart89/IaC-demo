#!/bin/bash

rm -rf /var/www/html/*
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# DB user / password
db="$1"
pass="$2"

# Site URL
url="$(hostname -I | cut -d' ' -f1)"

# Site title
title="$3"

# Admin user
user="$4"
password="$5"
email="$6"

read -d '' sql << EOF
    CREATE DATABASE IF NOT EXISTS $db;
    CREATE USER '$db'@'%' IDENTIFIED BY '$pass';
    GRANT ALL ON $db.* TO '$db'@'%';
    FLUSH PRIVILEGES;
EOF

mysql -e "$sql"
wp --allow-root core download --locale=ru_RU
wp --allow-root core config --dbname=$db --dbuser=$db --dbpass=$pass --dbhost=localhost --skip-check
wp --allow-root core install --url="$url" --title="$title" --admin_user=$user --admin_password=$password --admin_email=$email --skip-email
wp --allow-root core update
wp --allow-root core update-db
wp --allow-root plugin update --all
