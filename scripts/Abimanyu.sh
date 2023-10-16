echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install wget unzip nginx php php-fpm libapache2-mod-php7.0 -y
wget -O file.zip "https://drive.google.com/uc?export=download&id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX"
unzip file.zip
rm -rf /var/www/arjuna.a14
mv arjuna.yyy.com /var/www/arjuna.a14

echo '
server {
            listen 8002;
            root /var/www/arjuna.a14;
            index index.php index.html index.htm;
            server_name arjuna;
            location / {
                        try_files $uri $uri/ /index.php?$query_string;
            }
            location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
            }
location ~ /\.ht {
                        deny all;
	}
	error_log /var/log/nginx/arjuna_error.log;
	access_log /var/log/nginx/arjuna_access.log;
}
' > /etc/nginx/sites-available/arjuna.a14

ln -s /etc/nginx/sites-available/arjuna.a14 /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default
service nginx start
service nginx restart
service php7.0-fpm start

wget -O file.zip "https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc"
unzip file.zip
rm -rf /var/www/abimanyu.a14
mv abimanyu.yyy.com /var/www/abimanyu.a14
rm file.zip
service apache2 start

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.a14
        ServerName abimanyu.a14.com
        ServerAlias www.abimanyu.a14.com
        <Directory /var/www/abimanyu.a14.com/home>
                Options +Indexes
        </Directory>
Redirect permanent /index.php/home http://www.abimanyu.a14.com/home/
Redirect permanent /10.6.3.3/ https://www.abimanyu.a14.com
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</Virtualhost>
' > /etc/apache2/sites-available/abimanyu.a14.com.conf

a2ensite abimanyu.a14.com
a2dissite 000-default.conf
mkdir /var/www/abimanyu.a14/home

wget -O file.zip "https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS"
unzip file.zip
rm -rf /var/www/parikesit.abimanyu.a14
mv parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.a14
rm file.zip
a2enmod alias

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/parikesit.abimanyu.a14
        ServerName parikesit.abimanyu.a14.com
        ServerAlias www.parikesit.abimanyu.a14.com
        <Directory /var/www/parikesit.abimanyu.a14/public>
                Options +Indexes
        </Directory>
        <Directory /var/www/parikesit.abimanyu.a14/secret>
                Options -Indexes +FollowSymLinks
        </Directory>
        <Directory /var/www/parikesit.abimanyu.a14>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
        Alias /js /var/www/parikesit.abimanyu.a14/public/js
        ErrorDocument 403 /error/403.html
        ErrorDocument 404 /error/404.html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</Virtualhost>
' > /etc/apache2/sites-available/parikesit.abimanyu.a14.com.conf 

a2ensite parikesit.abimanyu.a14.com
a2enmod rewrite
mkdir /var/www/parikesit.abimanyu.a14/secret
cp /var/www/abimanyu.a14/home.html /var/www/parikesit.abimanyu.a14/secret/home.html

wget -O file.zip "https://drive.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6"
unzip file.zip
rm -rf /var/www/rjp.baratayuda.abimanyu.a14
mv rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.a14
rm file.zip

echo '
<VirtualHost *:14000>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/rjp.baratayuda.abimanyu.a14
    ServerName rjp.baratayuda.abimanyu.a14.com
    ServerAlias www.rjp.baratayuda.abimanyu.a14.com

    <Directory /var/www/rjp.baratayuda.abimanyu.a14>
        Options +Indexes
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Location />
            AuthType Basic
            AuthName "Restricted Area"
            AuthUserFile /etc/apache2/.htpasswd
            Require valid-user
    </Location>
</VirtualHost>

<VirtualHost *:14400>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/rjp.baratayuda.abimanyu.a14
    ServerName rjp.baratayuda.abimanyu.a14.com
    ServerAlias www.rjp.baratayuda.abimanyu.a14.com

    <Directory /var/www/rjp.baratayuda.abimanyu.a14>
        Options +Indexes
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Location />
            AuthType Basic
            AuthName "Restricted Area"
            AuthUserFile /etc/apache2/.htpasswd
            Require valid-user
    </Location>
</VirtualHost>
' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.a14.com.conf

echo 'Listen 14000' >> /etc/apache2/ports.conf
echo 'Listen 14400' >> /etc/apache2/ports.conf
a2ensite rjp.baratayuda.abimanyu.a14.com
htpasswd -c -B -b /etc/apache2/.htpasswd Wayang baratayudaa14
a2enmod authn_core
a2enmod auth_basic
a2enmod authn_file

echo '
RewriteEngine On
RewriteCond %{REQUEST_URI} ^(.*)(abimanyu)(.*)\.(png|jpg)
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.a14.com/public/images/abimanyu.png [L,R]
' > /var/www/parikesit.abimanyu.a14/.htaccess

rm /var/www/parikesit.abimanyu.a14/secret/.htaccess
service apache2 restart
