# Public-Pi-hole
Public Pi-hole with Unbound (Unbound is a validating, recursive, caching DNS resolver)

**Install:**
```
wget https://raw.githubusercontent.com/scriptzteam/Public-Pi-hole/main/install.sh
chmod +x install.sh
./install.sh
```

**Test DNSSEC validation:**
```
dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335
status: SERVFAIL

dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335
status: NOERROR
```
The first dig command should give a status report of SERVFAIL and no IP address.
The second should give NOERROR plus an IP address.


**ANY queries not allowed by default:**
```
dig ANY sigok.verteiltesysteme.net @127.0.0.1 -p 5335
status: NOTIMP
```
