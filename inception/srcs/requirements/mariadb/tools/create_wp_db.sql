-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS wordpress

-- create a user and grant him all privileges on the database
DROP USER IF EXISTS 'wp_user'@'%';
CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Apply the privileges
FLUSH PRIVILEGES;