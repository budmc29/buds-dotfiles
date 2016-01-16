apt-get update --assume-yes     update everything

apt-get install apache2 --assume-yes     install apache

add-apt-repository ppa:ondrej/php5     install php5

apt-get update && apt-get install php5 -assume-yes      to install php 5.5

apt-get install php5 libapache2-mod-php5 --assume-yes     instal something for php5

apt-get -y install php5-mysql --assume-yes  PDO not found

apt-get install php5-mcrypt --assume-yes     install mcrypt for laravel

apt-get install mysql-server --assume-yes     install mysql1

curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer    instal compsoer

apt-get install git-core --assume-yes     install git

cd /var/www/ && git clone https://github.com/upostme/upostme     clone our repository in www dir

vim /etc/apache2/sites-available/000-default.conf      open apache config

or vim /etc/apache2/sites-available/000-default      if the other one is empty

     change folder to /www/upostme/public     add root of apache here

service apache2 restart 

cd /var/www/upostme && composer update     install laravel 

if needer    
            apt-get install php5-curl

chgrp -R www-data /var/www/upostme && chmod -R 775 /var/www/upostme/app/storage && chmod -R 775 /var/www/upostme/public     allow laravel to write to these folders

echo ServerName $HOSTNAME > /etc/apache2/conf.d/fqdn     quick fix for apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName

vim /etc/apache2/apache2.conf     edit apache config

     search /<Directory /var/www and AllowOverride all        make htacces work

sudo a2enmod rewrite     allow htacces to rewrite

service apache2 restart

apt-get install php5-mysql     install mysql

service apache2 restart

php artisan migrate && php artisan db:seed     migrate the database

apt-get install php5-gd --assume-yes && service apache2 restart     install gd for image manipulation

 

sudo apt-get install php5-curl --assume-yes          install curl for ssl packages

 sharing a folder from windows to linux server (development)

apt-get install samba --assume-yes
apt-get install cifs-utils --assume-yes

vim /etc/samba/smb.conf
     add
     [upostme]
          comment = Ubuntu File Server
          path = /var/www/
          guest ok = yes
          read only = no
          create mask = 0755

if i can't access the folder via windows share then
     chmod -R 0777 upostme

service smbd restart && service nmbd restart

connect to \\192.168.33.10\upostme



