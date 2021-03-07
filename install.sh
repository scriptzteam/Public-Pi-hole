#Version: v1.0.0

#Check
if [[ $# -eq 0 ]] ; then
    echo "Run as - install.sh hidden_admin_dir"
    exit 1
fi

#Install
apt update
apt upgrade
apt install unbound
wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints
mv /etc/unbound/unbound.conf.d/pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf-backup
wget https://raw.githubusercontent.com/scriptzteam/Public-Pi-hole/main/files/pi-hole.conf -O /etc/unbound/unbound.conf.d/pi-hole.conf
#systemctl disable unbound-resolvconf.service
#systemctl stop unbound-resolvconf.service
#systemctl restart dhcpcd
service unbound restart
#mv /etc/resolv.conf /etc/resolv.conf-backup
#echo "nameserver 127.0.0.1" > /etc/resolv.conf
#chattr -f +i /etc/resolv.conf
#service unbound restart

# Test validation
# You can test DNSSEC validation using
# dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335
# dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335
# The first command should give a status report of SERVFAIL and no IP address.
# The second should give NOERROR plus an IP address.

echo "
|***********************************************************************************|
| Now you are going to install Pi-hole, as DNS use custom DNS (unbound) - 127.0.0.1 |
|***********************************************************************************|
"
sleep 2
# Pi-hole install
curl -sSL https://install.pi-hole.net | bash

# Add domain blocklist
echo "https://dbl.oisd.nl/" > /etc/pihole/adlists.list
pihole -g

# Move admin dir to dir specified in argument - hidden_admin_dir
# Remove pihole dir
mv /var/www/html/admin/ /var/www/html/$1
rm -rf /var/www/html/pihole/

# Unound stats:
# unbound-control stats_noreset
