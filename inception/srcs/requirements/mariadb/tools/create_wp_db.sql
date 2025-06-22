-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS wordpress;

-- Create a general WordPress user
DROP USER IF EXISTS '${WP_USER}'@'%';
CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${WP_USER}'@'%';

-- Create an admin user
DROP USER IF EXISTS '${WP_ADMIN_USER}'@'%';
CREATE USER '${WP_ADMIN_USER}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${WP_ADMIN_USER}'@'%';

-- Apply the privileges
FLUSH PRIVILEGES;