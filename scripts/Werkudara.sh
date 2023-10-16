echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

echo '
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

zone "baratayuda.abimanyu.a14.com" {
    type master;
    file "/etc/bind/baratayuda/baratayuda.abimanyu.a14.com";
};
' > /etc/bind/named.conf.local

echo '
options {
	directory "/var/cache/bind";
	allow-query{any;};
	auth-nxdomain no;
	listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

mkdir /etc/bind/baratayuda

echo '
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
@               IN      A       10.6.3.3
www             IN      CNAME   baratayuda.abimanyu.a14.com.
rjp	IN	A	10.6.3.3
www.rjp	IN	CNAME	rjp
' > /etc/bind/baratayuda/baratayuda.abimanyu.a14.com

service bind9 restart
