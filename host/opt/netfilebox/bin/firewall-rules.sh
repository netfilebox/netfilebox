#!/bin/bash
#  Allow all loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use lo0
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 -j REJECT

#  Accept all established inbound connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#  Allow all outbound traffic - you can modify this to only allow certain traffic
iptables -A OUTPUT -j ACCEPT

#  Allow HTTP/HTTPS connections from anywhere (the normal ports for websites and SSL).
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow api from internal network 
#-A INPUT -s @NETWORK_IP@/24 -p tcp --dport 8080 -j ACCEPT

#  Allow SSH connections
#
#  The -dport number should be the same port number you set in sshd_config
#
iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT

#  Allow ping
iptables -A INPUT -p icmp -j ACCEPT

# Allow mail 
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp --dport 587 -j ACCEPT
iptables -A INPUT -p tcp --dport 993 -j ACCEPT

# OpenVPN
iptables -A INPUT -p udp --dport 1194 -j ACCEPT
iptables -A OUTPUT -p udp --sport 1194 -j ACCEPT

# Drop all other inbound
iptables -A INPUT -j DROP

####ipv6

#  Allow all loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use lo0
ip6tables -A INPUT -i lo -j ACCEPT

#  Accept all established inbound connections
ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#  Allow all outbound traffic - you can modify this to only allow certain traffic
ip6tables -A OUTPUT -j ACCEPT

#  Allow HTTP/HTTPS connections from anywhere (the normal ports for websites and SSL).
ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow api from internal network 
#-A INPUT -s @NETWORK_IP@/24 -p tcp --dport 8080 -j ACCEPT

#  Allow SSH connections
#
#  The -dport number should be the same port number you set in sshd_config
#
ip6tables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT

#  Allow ping
ip6tables -A INPUT -p icmp -j ACCEPT

# Allow mail 
ip6tables -A INPUT -p tcp --dport 25 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 587 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 993 -j ACCEPT

# OpenVPN
ip6tables -A INPUT -p udp --dport 1194 -j ACCEPT
ip6tables -A OUTPUT -p udp --sport 1194 -j ACCEPT

# Drop all other inbound
ip6tables -A INPUT -j DROP
