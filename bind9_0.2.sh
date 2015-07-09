sudo apt-get install && apt-get install bind9 bind9utils bind9-doc dnsutils -y

echo "enabling BIND to IPv4 mode "
sleep 2s

echo '# run resolvconf?
RESOLVCONF=no

# startup options for the server
OPTIONS="-4 -u bind" ' > /etc/default/bind9

# cat /etc/default/bind9

echo "enter your system's hostname., e.g, host1 or mydns, dns1 etc.,: \n"
read -r host_name

echo "enter domain address., e.g., example.com don't include hostname i.e., host1.example.com , where host1 is your machine's hostname..: \n"
read -r domain_name

echo ' enter ip address for which use as "domain name service" e.g. 192.168.1.10 \n'
read -r ip_addr

echo "your system's hostname is '$host_name', ip address '$ip_addr', and you have enter domain address as '$domain_name', your FQDN is : '$host_name.$domain_name' "
sleep 3s
clear

echo "$ip_addr		$host_name.$domain_name		$host_name" > /etc/hosts
echo "$host_name" > /etc/hostname

cat /etc/hosts

sleep 2s
clear

cat /etc/hostname
sleep 2s
clear

sudo /etc/init.d/networking restart
sudo ifdown -a && ifup -a && resolvconf -u

cat /etc/resolv.conf

sleep 2s
clear

echo "; FORWARD ZONE
; BIND data file for local loopback interface
;
"$"TTL    604800
@       IN      SOA     $host_name.$domain_name. root.$host_name.$domain_name. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $host_name.$domain_name.
@       IN      A       $ip_addr
$host_name      IN      A               $ip_addr" > /etc/bind/db.forward

echo "your forward zone file is like this:  \n \n"
cat /etc/bind/db.forward
sleep 5s
clear


echo "

        N       N       N       H               Class C --> it contain's 3 Networks & 1 Host      
        _       _       _       _                                       e.g., 192.168.1.20,in reverse zone   
        1       2       3       1                                       we use '20' as host part into          
                                                                        'db.rev' file for reverse zone     
                                                                        file. i.e., 1                  
        N       N       H       H               Class B --> it contain's 2 Networks & 2 Hosts            
        _       _       _       _                                       e.g., 172.16.0.13, in reverse zone  
        1       2       1       2                                       we use '13.0'as host part into
                                                                        'db.rev' file for reverse zone     
                                                                        file. i.e., 2--1                                         
        N       H       H       H               Class A --> it contain's 1 Network & 3 Hosts             
        _       _       _       _                                       e.g., 10.1.1.20, in reverse zone in:q!







        1       1       2       3                                       we use '20.1.1' into
                                                                        'db.rev' file for reverse zone
                                                                        file. i.e., 3--2--1"
ifconfig
sleep 3s

echo "now read the above note carefully, enter host part of your ip in reverse order: \n \n"
read -r rev_ip

echo "\n you have entered Host Part as $rev_ip"
sleep 2s
clear

echo "
; REVERSE ZONE
; BIND reverse data file for local loopback interface

"$"TTL    604800
@       IN      SOA     $host_name.$domain_name. root.$host_name.$domain_name. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $host_name.
$rev_ip   IN      PTR     $host_name.$domain_name." > /etc/bind/db.reverse

sleep 3s
echo"your reverse zone file is like this:  \n \n"

cat /etc/bind/db.reverse
sleep 5s
clear


echo "

        N       N       N       H               Class C --> it contain's 3 Network & 1 Host      
        _       _       _       _                                       e.g., 192.168.0.20,in reverse zone   
        1       2       3       1                                       we use '0.168.192' into              
                                                                        'named.conf.local' configuration     
                                                                        file. i.e., 3--2--1                  
        N       N       H       H               Class B --> it contain's 2 Network & 2 Host              
        _       _       _       _                                       e.g., 172.16.0.13, in reverse zone  
        1       2       1       2                                       we use '16.172' into
                                                                        'named.conf.local' configuration     
                                                                        file. i.e., 2--1                                         
        N       H       H       H               Class A --> it contain's 1 Network & 3 Host              
        _       _       _       _                                       e.g., 10.1.1.20, in reverse zone 
        1       1       2       3                                       we use '10' into
                                                                        'named.conf.local' configuration"

ifconfig
sleep 3s

echo "now read the above note carefully, enter network  part of your ip in reverse order: \n \n"
read -r for_ip

echo "\n you have entered Network Part as $for_ip"
sleep 2s
clear

echo "// Forward zone
zone \"$domain_name\" {
	type master;
	file \"/etc/bind/db.forward\";
};
//Reverse zone
zone  \"$for_ip.in-addr.arpa\" {
	type master;
	file \"/etc/bind/db.reverse\";
};" >> /etc/bind/named.conf.local

sleep 3s

sudo cat /etc/bind/named.conf.local
sleep 5s

sudo service bind9 restart

sudo nslookup $ip_addr
sleep 3s
clear

sudo nslookup $domain_name
sleep 3s
clear

printf "Script Finished Successful :-D\n"
printf "\n"
printf "now use any browser and type http://nagios_server_public_ip/nagios \n"
printf "-------------------------- \n"
printf "USERNAME : nagiosadmin \n"
printf "PASSWORD : THAT U HAVE ENTER AT TIME OF RUNNING SCRIPT \n"
printf "-------------------------- \n"
printf "now use any browser and type http://nagios_server_public_ip/nagios \n"
printf "\n"
printf "if u get error processing php5 (--configure): \n"
printf "USE BELOW COMMAND & RE-EXECUTIVE THE SCRIPT AND REBOOT SYSTEM \n"
printf "sudo apt-get remove --purge php5-common php5-cli \n"
printf "\n"
printf "T: @ackbote\n"
printf "E:hel.venket@gmail.com\n"
printf "M:+918866442277\n"
printf "\n"
printf "Always share what you learn, in easy and confortable way --\n"
printf "\n"
printf "\n"

sleep 7s

exit

