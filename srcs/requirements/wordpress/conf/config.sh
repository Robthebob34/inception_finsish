#!/bin/bash

# Wait for MariaDB to be ready
while ! mariadb -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Create wp-config.php if it doesn't exist
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --dbname=$DB_NAME \
                    --dbuser=$DB_USER \
                    --dbpass=$DB_PASSWORD \
                    --dbhost=$DB_HOST \
                    --path=/var/www/wordpress \
                    --allow-root

    # Install WordPress core
    wp core install --url=$WP_URL \
                   --title=$WP_TITLE \
                   --admin_user=$WP_ADMIN_USER \
                   --admin_password=$WP_ADMIN_PASSWORD \
                   --admin_email=$WP_ADMIN_EMAIL \
                   --path=/var/www/wordpress \
                   --allow-root

    # Create the Inception page
    wp post create --post_type=page \
                  --post_title='Inception' \
                  --post_content='Inception' \
                  --post_status=publish \
                  --post_author=1 \
                  --path=/var/www/wordpress \
                  --allow-root

    # Set it as the homepage
    wp option update show_on_front 'page' --allow-root
    wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename=inception --field=ID --allow-root) --allow-root
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F