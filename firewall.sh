#!/bin/bash
# default policy
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

ip6tables -P INPUT DROP
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP

# loopback interface
iptables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

# drop invalid
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP

# established/related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELAT
ED -j ACCEPT
ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELA
TED -j ACCEPT

# ping (you can remove if you want)
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCE
PT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEP
T
ip6tables -A INPUT -p icmpv6 -j ACCEPT
ip6tables -A OUTPUT -p icmpv6 -j ACCEPT

# SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# wireguard (udp/49914) - VPN
iptables -A INPUT -p udp --dport 49914 -j ACCEPT
iptables -A OUTPUT -p udp --sport 49914 -j ACCEPT

# allow forwarding for wireguard (because we DROP on FORWARD chain by default. Change "ens3" to "eth0" if you are using the old network interface names)
iptables -A FORWARD -i wg0 -o ens3 -j ACCEPT
iptables -A FORWARD -i ens3 -o wg0 -j ACCEPT
ip6tables -A FORWARD -i wg0 -o ens3 -j ACCEPT
ip6tables -A FORWARD -i ens3 -o wg0 -j ACCEPT

# port forwarding rules
bash /root/port-forward.sh