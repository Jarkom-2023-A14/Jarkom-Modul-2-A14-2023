echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install wget unzip nginx php php-fpm -y
wget -O file.zip "https://drive.google.com/uc?export=download&id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX"
unzip file.zip
rm -rf /var/www/arjuna.a14
mv arjuna.yyy.com /var/www/arjuna.a14

echo '
server {
            listen 8003;
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
