Installing & Auto Configuring  Bind9 (DNS Server)  on Ubuntu with a Script …  bind9_0.2.sh

Senario :
	I have used virtualBox with Ubuntu Server 14, with IP address : 192.168.1.153 (DNS); Hostname: host1; Domain Name : example.xxx with a internet enabled Gateway IP : 192.168.1.224

	✓	apt-get update && apt-get install git vim -y  
	✓	git clone https://github.com/slktechlabs/bind9 /tmp/bind9 && cd /tmp/bind9 && sh bind9_0.2.sh 
	✓	go to vim /etc/network/interface;  1. change dns-nameservers IP with your system/server IP i.e., 192.168.1.153 & 
	 2. change dns-search with your desire domain name i.e., example.xxx
	✓	then finally reboot it; its mandatory to reflect the change, in hostname, updating new dns then only it works.

  Testing : -

	✓	nslookup 192.168.1.153 ( IP to Name resolve )
	⁃	Output :
		
		Server:		192.168.1.153
		Address:	192.168.1.153#53

		153.1.168.192.in-addr.arpa	name = host1.example.xxx.

	✓	nslookup example.xxx ( Name to IP resolve )
	⁃	Output :
		
		Server:		192.168.1.153
		Address:	192.168.1.153#53

		Name:	example.xxx
		Address: 192.168.1.153

	✓	Test dig -x 192.168.1.153 & dig -x example.xxx

root@host1:~# dig -x 192.168.1.153

; <<>> DiG 9.9.5-3ubuntu0.7-Ubuntu <<>> -x 192.168.1.153
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 43233
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;153.1.168.192.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
153.1.168.192.in-addr.arpa. 604800 IN	PTR	host1.example.xxx.

;; AUTHORITY SECTION:
1.168.192.in-addr.arpa.	604800	IN	NS	host1.

;; Query time: 5 msec
;; SERVER: 192.168.1.153#53(192.168.1.153)
;; WHEN: Mon Mar 07 18:21:38 IST 2016
;; MSG SIZE  rcvd: 105

root@host1:~# dig -x example.xxx

; <<>> DiG 9.9.5-3ubuntu0.7-Ubuntu <<>> -x example.xxx
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 64754
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;xxx.example.in-addr.arpa.	IN	PTR

;; AUTHORITY SECTION:
in-addr.arpa.		3600	IN	SOA	b.in-addr-servers.arpa. nstld.iana.org. 2015073083 1800 900 604800 3600

;; Query time: 2276 msec
;; SERVER: 192.168.1.153#53(192.168.1.153)
;; WHEN: Mon Mar 07 18:21:57 IST 2016
;; MSG SIZE  rcvd: 121
