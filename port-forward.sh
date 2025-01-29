# Tixati - TCP 
iptables -t nat -A PREROUTING -d 18.197.221.133 -p tcp --dport 48319 -j DNAT --to
-dest 10.66.66.2:48319
iptables -t filter -A INPUT -p tcp -d 10.66.66.2 --dport 49914 -j ACCEPT

ip6tables -t nat -A PREROUTING -d 2a05:d014:1626:9500:8d29:c131:cb4b:c397 -p tcp --dport 49914
 -j DNAT --to-dest [fd42:69:69::2]:48319
ip6tables -t filter -A INPUT -p tcp -d fd42:69:69::2 --dport 49914 -j ACCEPT

# Tixati - UDP/uTP
iptables -t nat -A PREROUTING -d 18.197.221.133 -p udp --dport 49914 -j DNAT --to
-dest 10.66.66.2:48319
iptables -t filter -A INPUT -p udp -d 10.66.66.2 --dport 49914 -j ACCEPT

ip6tables -t nat -A PREROUTING -d 2a05:d014:1626:9500:8d29:c131:cb4b:c397 -p udp --dport 49914
 -j DNAT --to-dest [fd42:69:69::2]:48319
ip6tables -t filter -A INPUT -p udp -d fd42:69:69::2 --dport 49914 -j ACCEPT
