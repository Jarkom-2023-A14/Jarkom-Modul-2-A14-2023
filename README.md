# Jarkom-Modul-2-A14-2023

Ariella Firdaus Imata (5025211138)\
Richard Ryan (5025211141)\
Modul 2\
Kelompok 14

### 1. Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian sebagai berikut. Folder topologi dapat diakses pada drive berikut

**Pandudewanta :**

    auto eth0
    iface eth0 inet dhcp

    auto eth1
    iface eth1 inet static
        address 10.6.1.1
        netmask 255.255.255.0

    auto eth2
    iface eth2 inet static
        address 10.6.2.1
        netmask 255.255.255.0

    auto eth3
    iface eth3 inet static
        address 10.6.3.1
        netmask 255.255.255.0

**Nakula :**

    auto eth0
    iface eth0 inet static
        address 10.6.1.2
        netmask 255.255.255.0
        Gateway 10.6.1.1

**Sadewa :**

    auto eth0
    iface eth0 inet static
        address 10.6.1.3
        netmask 255.255.255.0
        Gateway 10.6.1.1

**Yudhistira** :

    auto eth0
    iface eth0 inet static
        address 10.6.1.4
        netmask 255.255.255.0
        Gateway 10.6.1.1

**Werkudara** :

    auto eth0
    iface eth0 inet static
        address 10.6.1.5
        netmask 255.255.255.0
        Gateway 10.6.1.1

**Arjuna** :

    auto eth0
    iface eth0 inet static
        address 10.6.2.2
        netmask 255.255.255.0
        Gateway 10.6.2.1

**Prabukusuma** :

    auto eth0
    iface eth0 inet static
        address 10.6.3.2
        netmask 255.255.255.0
        Gateway 10.6.3.1

**Abimanyu** :

    auto eth0
    iface eth0 inet static
        address 10.6.3.3
        netmask 255.255.255.0
        Gateway 10.6.3.1

**Wisanggeni** :

    auto eth0
    iface eth0 inet static
        address 10.6.3.4
        netmask 255.255.255.0
        Gateway 10.6.3.1

**Config Pada Node**

Jalankan iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.6.0.0/16 pada node Pandudewanata

Jalankan echo nameserver 192.168.122.1 > /etc/resolv.conf pada semua node lain


### 2. Buatlah website utama pada node arjuna dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok.

Jalankan `apt-get update` dan `apt-get install bind9 -y` pada node **Yudhistira**

Tambahkan berikut pada file */etc/bind/named.conf.local* pada node **Yudhistira**
    
    zone "arjuna.a14.com" {
        type master;
        file "/etc/bind/domain/arjuna.a14.com";
    };
    
Buat folder arjuna dengan perintah ``mkdir /etc/bind/domain`` pada node Yudhistira
Copykan file db.local ke folder arjuna tersebut dengan perintah `cp /etc/bind/db.local /etc/bind/domain/arjuna.a14.com`

Ubah isi file **arjuna.a14.com** menjadi berikut

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL	604800
    @	IN	SOA	arjuna.a14.com.	root.arjuna.a14.com. (
                2		            ; Serial
                604800		        ; Refresh
                        86400		; Retry
                        2419200		; Expire
                604800  )	        ; Negative Cache TTL
    ;
    @	IN	NS	    arjuna.a14.com.
    @	IN	A	    10.6.2.2	    ; IP Arjuna
    www	IN	CNAME	arjuna.a14.com.
Jalankan perintah `service bind9 restart` pada node **Yudhistira**\
Apabila ingin melakukan pengecekan, ubah isi file /etc/resolv.conf pada node Nakula menjadi nameserver 10.6.1.4 lalu `ping arjuna.a14.com` atau `ping www.arjuna.14.com` 


### 3. Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

Jalankan `apt-get update` dan `apt-get install bind9 -y` pada node **Yudhistira**
Tambahkan berikut pada file /etc/bind/named.conf.local pada node Yudhistira
zone "abimanyu.a14.com" {
	type master;
	file "/etc/bind/domain/abimanyu.a14.com";

};
Buat folder abimanyu dengan perintah mkdir /etc/bind/domain pada node **Yudhistira**

Copykan file db.local ke folder arjuna tersebut dengan perintah `cp /etc/bind/db.local /etc/bind/domain/abimanyu.a14.com`

Ubah isi file abimanyu.a14.com menjadi berikut

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL	604800
    @	IN	SOA	abimanyu.a14.com.	root.abimanyu.a14.com. (
                    2		; Serial
                604800		; Refresh
                86400		; Retry
                2419200		; Expire
                604800  )	; Negative Cache TTL
    ;
    @	IN	NS	abimanyu.a14.com.
    @	IN	A	10.6.3.3	; IP Abimanyu
    www	IN	CNAME	abimanyu.a14.com.


Jalankan perintah service bind9 restart pada node **Yudhistira**

Apabila ingin melakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.4. Lalu lakukan `ping abimanyu.a14.com` atau `ping www.abimanyu.14.com`


### 4. Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di **Yudhistira** dan mengarah ke Abimanyu.

Pada node Yudhistira, tambahkan baris parikesit	IN	A	10.6.3.3 pada file */etc/bind/domain/abimanyu.a14.com* sehingga file tersebut menjadi seperti berikut

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL	604800
    @	IN	SOA	abimanyu.a14.com.	root.abimanyu.a14.com. (
                    2		; Serial
                604800		; Refresh
                86400		; Retry
                2419200		; Expire
                604800  )	; Negative Cache TTL
    ;
    @	IN	NS	abimanyu.a14.com.
    @	IN	A	10.6.3.3
    www	IN	CNAME	abimanyu.a14.com.
    parikesit	IN	A	10.6.3.3

Jalankan perintah service bind9 restart pada node Yudhistira

Apabila ingin melakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.4, Lalu lakukan `ping parikesit.abimanyu.a14.com`


### 5. Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

Tambahkan berikut pada file */etc/bind/named.conf.local* di node Yudhistira

    zone "3.6.10.in-addr.arpa" {
        type master;
        file "/etc/bind/domain/3.6.10.in-addr.arpa";
    };

Copykan file **db.local** ke folder arjuna tersebut dengan perintah `cp /etc/bind/db.local /etc/bind/domain/3.6.10.in-addr.arpa`

Ubah file 3.6.10.in-addr.arpa pada node Yudhistira sebagai berikut
`
    ;
    ; BIND data file for local loopback interface
    ;
    $TTL	604800
    @	IN	SOA	abimanyu.a14.com.	root.abimanyu.a14.com. (
                    2		; Serial
                604800		; Refresh
                86400		; Retry
                2419200		; Expire
                604800  )	; Negative Cache TTL
    ;
    3.6.10.in-addr.arpa.	IN	NS	abimanyu.a14.com.
    3			IN	PTR	abimanyu.a14.com.
`
Apabila ingin melakukan pengecekan, pada node Nakula, lakukan apt-get update kemudian `apt-get install dnsutils -y` lalu ubah isi file */etc/resolv.conf* menjadi nameserver 10.6.1.4 kemudian gunakan perintah **host -t PTR 10.6.3.3**


### 6. Agar dapat tetap dihubungi ketika DNS Server **Yudhistira** bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

Ubah isi file */etc/bind/named.conf.local* pada node **Yudhistira** menjadi berikut

    zone "abimanyu.a14.com" {
        type master;
        notify yes;
        also-notify { 10.6.1.5; };
        allow-transfer { 10.6.1.5; };
        file "/etc/bind/domain/abimanyu.a14.com";
    };

    zone "arjuna.a14.com" {
        type master;
        notify yes;
        also-notify { 10.6.1.5; };
        allow-transfer { 10.6.1.5; };
        file "/etc/bind/domain/arjuna.a14.com";
    };
    zone "3.6.10.in-addr.arpa" {
        type master;
        notify yes;
        also-notify { 10.6.1.5; };
        allow-transfer { 10.6.1.5; };
        file "/etc/bind/domain/3.6.10.in-addr.arpa";
    };
Jalankan perintah `service bind9 restart` pada node **Yudhistira**

Tambahkan berikut pada file */etc/bind/named.conf.local* pada node **Werkudara**
    zone "abimanyu.a14.com" {
        type slave;
        masters { 10.6.1.4; };
        file "/var/lib/bind/abimanyu.a14.com";
    };

    zone "arjuna.a14.com" {
        type slave;
        masters { 10.6.1.4; };
        file "/var/lib/bind/arjuna.a14.com";
    };

    zone "3.6.10.in-addr.arpa" {
        type slave;
        masters { 10.6.1.4; };
        file "/var/lib/bind/3.6.10.in-addr.arpa";
    };

Jalankan perintah *service bind9 restart* pada node **Werkudara**

Apabila ingin melakukan pengecekan, pergi ke node Nakula dan ubah isi *file /etc/resolv*.conf menjadi nameserver 10.6.1.5

Kemudian, lakukan `ping abimanyu.a14.com` dan `ping arjuna.a14.com`

### 7. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari **Yudhistira** ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

**Setting DNS Master (Yudhistira)**

Pada Yudhistira, edit file */etc/bind/domain/abimanyu.a14.com* dan ubah menjadi seperti di bawah ini sesuai dengan pembagian IP kelompok masing-masing

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL    604800
    @       IN      SOA     abimanyu.a14.com. root.abimanyu.a14.com. (
                        2023101101         ; Serial
                            604800         ; Refresh
                            86400         ; Retry
                            2419200         ; Expire
                            604800 )       ; Negative Cache TTL
    ;
    @              	IN      NS      		abimanyu.a14.com.
    @               	IN      A       		10.6.3.3
    www             	IN      CNAME   	abimanyu.a14.com.
    parikesit       	IN      A       		10.6.3.3
    ns1             	IN      A       		10.6.1.5
    baratayuda    IN      NS      		ns1
    @               	IN      AAAA    	::1


Kemudian edit *file /etc/bind/named.conf.options* pada **Yudhistira** sebagai berikut

    //dnssec-validation auto;
    allow-query{any;};
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };

**Config pada delegasi (Werkudara)**

Pada delegasi edit file */etc/bind/named.conf.options* seperti berikut

    //dnssec-validation auto;
    allow-query{any;};
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };

Lalu edit file */etc/bind/named.conf.local* menjadi seperti gambar di bawah:
    
    zone "baratayuda.abimanyu.a14.com" {
            type master;
            file "/etc/bind/baratayuda/baratayuda.abimanyu.a14.com";
    };

Kemudian buat direktori dengan nama delegasi
    
    mkdir /etc/bind/baratayuda

Copy `db.local` ke direktori tersebut dan edit namanya menjadi `baratayuda.abimanyu.a14.com`

    cp /etc/bind/db.local /etc/bind/baratayuda/baratayuda.abimamyu.a14.com  

Kemudian edit file baratayuda.abimanyu.a14.com menjadi seperti dibawah ini

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL    604800
    @       IN      SOA     baratayuda.abimanyu.a14.com. root.baratayuda.abimanyu.a14.com. (
                        2023101101         ; Serial
                            604800         ; Refresh
                            86400         ; Retry
                            2419200         ; Expire
                            604800 )       ; Negative Cache TTL
    ;
    @               IN      NS      baratayuda.abimanyu.a14.com.
    @               IN      A       10.6.3.3                        ; IP Abimanyu
    www             IN      CNAME   baratayuda.abimanyu.a14.com.

```
Restart bind9
service bind9 restart
```
Testing menggunakan ping ke domain **baratayuda.abimanyu.a14.com** dan **www.baratayuda.abimanyu.a14.com** dari client.


### 8. Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.

Pada file */etc/bind/baratayuda/baratayuda.abimanyu.a14.com* di node **Werkudara**, tambahkan baris `rjp	IN	A	10.6.3.3` dan` www.rjp	IN	CNAME	rjp`, sehingga file tersebut menjadi seperti berikut

    ;
    ; BIND data file for local loopback interface
    ;
    $TTL	604800
    @	IN	SOA	baratayuda.abimanyu.a14.com.	root.baratayuda.abimanyu.a14.com. (
                    2		; Serial
                604800		; Refresh
                86400		; Retry
                2419200		; Expire
                604800  )	; Negative Cache TTL
    ;
    @	IN	NS	baratayuda.abimanyu.a14.com.
    @	IN	A	10.6.3.3
    www	IN	CNAME	baratayuda.abimanyu.a14.com.
    rjp	IN	A	10.6.3.3
    www.rjp	IN	CNAME	rjp

Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node **Nakula** menjadi nameserver 10.6.1.5 kemudian gunakan perintah `host -t A rjp.baratayuda.abimanyu.a14.com` dan `host -t A www.rjp.baratayuda.abimanyu.a14.com`

### 9. Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.


### 10. Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh

    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003

Pada node **Arjuna**, gunakan perintah `apt-get update` dan `apt-get install nginx -y`

Pada node **Prabukusuma, Abimanyu, dan Wisanggeni**, gunakan perintah `apt-get update` dan `apt-get install wget unzip nginx php php-fpm -y`

Pada node **Prabukusuma, Abimanyu, dan Wisanggeni**, panggil perintah `wget -O file.zip “https://drive.google.com/uc?export=download&id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX”`, kemudian `unzip file.zip`, kemudian `mv arjuna.yyy.com /var/www/arjuna.a14` dan terakhir `rm file.zip`
Buka file */etc/nginx/sites-available/arjuna.a14* dan isi sebagai berikut

    server {

                listen 8001;

                root /var/www/arjuna.a14;

                index index.php index.html index.htm;
                server_name arjuna;

                location / {
                            try_files $uri $uri/ /index.php?$query_string;
                }

                # pass PHP scripts to FastCGI server
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

Ganti baris listen **8001 (pada Prabukusuma)** menjadi listen **8002 (pada Abimanyu)** atau **listen 8003 (pada Wisanggeni)**
Pada ketiga server, jalankan `ln -s /etc/nginx/sites-available/arjuna.a14 /etc/nginx/sites-enabled` lalu `rm -rf /etc/nginx/sites-enabled/default` kemudian `service nginx restart` dan terakhir `service php7.0-fpm start`
Pada node Arjuna, buat file */etc/nginx/sites-available/lb-arjuna* dengan isi sebagai berikut

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

Jalankan `ln -s /etc/nginx/sites-available/lb-arjuna /etc/nginx/sites-enabled` lalu `rm -rf /etc/nginx/sites-enabled/default` kemudian `service nginx restart`

Jika ingin dilakukan pengecekan, pada server **Nakula** set */etc/resolv.conf* menjadi nameserver 10.6.1.5 kemudian panggil `lynx arjuna.a14.com`


### 11. Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

Pada node **Abimanyu**, panggil perintah `wget -O file.zip “https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc”`, kemudian `unzip file.zip`, kemudian `mv abimanyu.yyy.com /var/www/abimanyu.a14` dan terakhir `rm file.zip`

Pada node **Abimanyu**, lakukan perintah `apt–get update` dan `apt-get install apache2 php libapache2-mod-php7.0 -y`, kemudian jalankan perintah `service apache2 start`

Gunakan perintah `cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.a14.com.conf` untuk membuat file konfigurasi web server **abimanyu.a14.com**

Pada file */etc/apache2/sites-available/abimanyu.a14.com.conf*, ubah DocumentRoot menjadi **/var/www/abimanyu.a14**, ServerName menjadi **abimanyu.a14.com**, ServerAlias menjadi **www.abimanyu.a14.com** sehingga file tersebut menjadi seperti berikut

    <VirtualHost *:80>
            ServerAdmin webmaster@localhost
            DocumentRoot /var/www/abimanyu.a14
            ServerName abimanyu.a14.com
            ServerAlias www.abimanyu.a14.com
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Gunakan perintah `a2ensite abimanyu.a14.com` untuk mengaktifkan konfigurasi web  tersebut kemudian lakukan `service apache2 restart`

Jika ingin dilakukan pengecekan, pada server Nakula set */etc/resolv.conf* menjadi nameserver 10.6.1.5 kemudian panggil `lynx abimanyu.a14.com`

Keterangan : Kemungkinan besar memang abimanyu.a14.com/home bakal return 404 soalnya nggak ada folder home. Buat folder home dengan melakukan `mkdir /var/www/abimanyu.a14/home`, terus ganti */etc/apache2/sites-available/abimanyu.a14.com.conf*, jadi ini

    <VirtualHost *:80>
            ServerAdmin webmaster@localhost
            DocumentRoot /var/www/abimanyu.a14
            ServerName abimanyu.a14.com
            ServerAlias www.abimanyu.a14.com
            <Directory /var/www/abimanyu.a14.com/home>
                    Options +Indexes
            </Directory>
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>


### 12. Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.

Ubah file */etc/apache2/sites-available/abimanyu.a14.com.conf* menjadi

    <VirtualHost *:80>
            ServerAdmin webmaster@localhost
            DocumentRoot /var/www/abimanyu.a14
            ServerName abimanyu.a14.com
            ServerAlias www.abimanyu.a14.com
            <Directory /var/www/abimanyu.a14.com/home>
                    Options +Indexes
            </Directory>
    Redirect permanent /index.php/home http://www.abimanyu.a14.com/home/
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Kemudian lakukan `service apache2 restart`

### 13. Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

Pada node Abimanyu, panggil perintah `wget -O file.zip “https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS”`, kemudian `unzip file.zip`, kemudian `mv parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.a14` dan terakhir `rm file.zip`

Buat file */etc/apache2/sites-available/parikesit.abimanyu.a14.com.conf* sebagai berikut

    <VirtualHost *:80>
            ServerAdmin webmaster@localhost
            DocumentRoot /var/www/parikesit.abimanyu.a14
            ServerName parikesit.abimanyu.a14.com
            ServerAlias www.parikesit.abimanyu.a14.com
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Lakukan `a2ensite parikesit.abimanyu.a14.com`

Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah lynx `parikesit.abimanyu.a14.com`

### 14. Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

Pada node Abimanyu, lakukan `mkdir /var/www/parikesit.abimanyu.a14/secret`
Ubah file */etc/apache2/sites-available/parikesit.abimanyu.a14.com.conf* menjadi seperti berikut

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
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Buat file */var/www/parikesit.abimanyu.a14/secret/.htaccess* dengan isi

    Reuire all denied

Lakukan `service apache2 restart`
Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx parikesit.abimanyu.a14.com` dan navigasi ke folder **/secret**


### 15. Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

Tambahkan line `ErrorDocument 403 /error/403.php` dan `ErrorDocument 404 /error/404.php` pada */etc/apache2/sites-available/parikesit.abimanyu.a14.com.conf* sehingga file tersebut menjadi

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
            ErrorDocument 403 /error/403.html
            ErrorDocument 404 /error/404.html
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node **Nakula** menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx parikesit.abimanyu.a14.com/secret` (403 forbidden) dan juga `lynx parikesit.abimanyu.a14.com/abc` (404 not found)


### 16. Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi www.parikesit.abimanyu.yyy.com/js

Tambahkan line `Alias /js /var/www/parikesit.abimanyu.a14/public/js` pada */etc/apache2/sites-available/parikesit.a14.com.conf* sehingga file tersebut menjadi
    
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
            Alias /js /var/www/parikesit.abimanyu.a14/public/js
            ErrorDocument 403 /error/403.html
            ErrorDocument 404 /error/404.html
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </Virtualhost>

Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx parikesit.abimanyu.a14.com/js`

### 17. Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.

Pada node Abimanyu, panggil perintah `wget -O file.zip “https://drive.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6”`, kemudian `unzip file.zip`, kemudian `mv rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.a14` dan terakhir `rm file.zip`
Buat file */etc/apache2/sites-available/rjp.baratayuda.abimanyu.a14.com.conf* dengan isi berikut

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
    </VirtualHost>

Buka file */etc/apache2/ports.conf* dan tambahkan baris `Listen 14000` dan `Listen 14400`

Jalankan perintah `a2ensite rjp.baratayuda.abimanyu.a14.com` kemudian `service apache2 restart`

Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx rjp.baratayuda.abimanyu.a14.com:14000` dan `lynx rjp.baratayuda.abimanyu.a14.com:14400`

### 18. Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.

Ubah file */etc/apache2/sites-available/rjp.baratayuda.abimanyu.a14.com.conf* menjadi berikut

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

Jalankan perintah `htpasswd -c -B -b /etc/apache2/.htpasswd Wayang baratayudaa14` untuk menambahkan username dan password

Jalankan perintah `a2enmod authn_core`, `a2enmod auth_basic`, `a2enmod authn_file` dan `service apache2 restart`
Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx -auth=Wayang:baratayudaa14 rjp.baratayuda.abimanyu.a14.com:14000`   atau `lynx -auth=Wayang:baratayudaa14 rjp.baratayuda.abimanyu.a14.com:14400`


### 19. Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)

Ubah file */etc/apache2/sites-available/abimanyu.a14.com.conf* menjadi seperti berikut

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

Lakukan perintah `a2dissite 000-default.conf` lalu `service apache2 restart`
Apabila ingin dilakukan pengecekan, ubah isi file */etc/resolv.conf* pada node Nakula menjadi nameserver 10.6.1.5 kemudian gunakan perintah `lynx 10.6.3.3`

### 20. Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

Jalankan `a2enmod rewrite`

Buat file */var/www/parikesit.abimanyu.a14/.htaccess* dengan isi berikut

    RewriteEngine On
    RewriteCond %{REQUEST_URI} ^(.*)(abimanyu)(.*)\.(png|jpg)
    RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
    RewriteRule abimanyu http://parikesit.abimanyu.a14.com/public/images/abimanyu.png [L,R]

Jalankan `service apache2 restart`

Dapat dipanggil `lynx parikesit.abimanyu.a14.com/public/images/not-abimanyu.png` pada client untuk melakukan pengecekan. 
