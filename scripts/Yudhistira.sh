echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

echo '
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
' > /etc/bind/named.conf.local

mkdir /etc/bind/domain

echo '
;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	arjuna.a14.com.	root.arjuna.a14.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800  )	; Negative Cache TTL
;
@	IN	NS	arjuna.a14.com.
@	IN	A	10.6.2.2
www	IN	CNAME	arjuna.a14.com.
' > /etc/bind/domain/arjuna.a14.com

echo '
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
@		IN      NS	abimanyu.a14.com.
@		IN      A	10.6.3.3
www		IN      CNAME	abimanyu.a14.com.
parikesit	IN      A	10.6.3.3
ns1		IN      A	10.6.1.5
baratayuda	IN      NS	ns1
@		IN      AAAA	::1
' > /etc/bind/domain/abimanyu.a14.com

echo '
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
' > /etc/bind/domain/3.6.10.in-addr.arpa

echo '
options {
	directory "/var/cache/bind";
	allow-query{any;};
	auth-nxdomain no;
	listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

service bind9 restart
