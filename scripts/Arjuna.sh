echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nginx -y

echo '
upstream myweb  {
        server 10.6.3.2:8001;
        server 10.6.3.3:8002;
        server 10.6.3.4:8003;
}

server {
        listen 80;
        server_name arjuna;

        location / {
                proxy_pass http://myweb;
        }
}
' > /etc/nginx/sites-available/lb-arjuna

ln -s /etc/nginx/sites-available/lb-arjuna /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default
service nginx start
service nginx restart
