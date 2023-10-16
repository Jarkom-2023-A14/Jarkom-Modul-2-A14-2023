echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install dnsutils lynx -y
echo nameserver 10.6.1.5 > /etc/resolv.conf
