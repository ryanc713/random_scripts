#!/bin/bash

# Run as root or die
if [[ $EUID -ne 0 ]]; then
clear
echo "Script must be run as root."
exit 2
fi
# Update the Server
apt update && apt upgrade -y

# Install Apache2, PHP7.4-FPM, Mariadb-Server and PHPmyadmin
apt install apache2 apache2-utils mariadb-server mariadb-client php7.4 libapache2-mod-php7.4 php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline phpmyadmin -y

# Start and Enable
systemctl enable apache2 && systemctl start apache2
systemctl enable mariadb && systemctl start mariadb

# Fix Web Root permissions
chown www-data:www-data /var/www/html/ -R

# Fix Apache servername error
echo "ServerName localhost">>/etc/apache2/conf-available/servername.conf
a2enconf servername.conf
systemctl reload apache2

# Enable php7.4-fpm
a2dismod php7.4
apt install php7.4-fpm
a2enmod proxy_fcgi setenvif
a2enconf php7.4-fpm
systemctl reload apache2
systemctl enable php7.4-fpm && systemctl start php7.4-fpm

# DB Setup
mysql_secure_installation

clear
echo "What domain are you going to run on this server?"
read domain
rm -rf /etc/apache2/sites-available/000-default.conf
touch /etc/apache2/sites-available/$domain.conf

# Setting up Virtual Host File
echo "<VirtualHost *:80>

        ServerName $domain
		ServerAlias www.$domain

        ServerAdmin admin@$domain
        DocumentRoot /var/www/$domain

        ErrorLog /var/log/$domain_error.log
        CustomLog /var/log/$domain_access.log combined

</VirtualHost>">>/etc/apache2/sites-available/$domain.conf

# Enabling Site
a2ensite $domain.conf
mkdir /var/www/$domain
chown www-data:www-data /var/www/$domain

# Turning off Indexes in Apache
sed -i 's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/apache2/apache2.conf

systemctl reload apache2