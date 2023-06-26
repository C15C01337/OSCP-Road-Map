#!/bin/bash

# Check for IP address argument
if [ $# -eq 0 ]; then
  echo "Error: Please provide an IP address as an argument." >&2
  exit 1
fi


# Run rustscan with all TCP ports 
echo "Scanning TCP Ports:"
docker run -it rustscan/rustscan:latest -t 2000 -a $1 --ulimit 5000 -b 3000  -- --min-rate 4500 -sV -sC | tee rustscan_$1.txt
echo "Scanning UDP Ports:"
nmap -sU --top-ports --min-rate 4500 $1 -T 1500 -oN all-portsudp_$1.txt

echo "Scan complete.!!! "

#ldap scan
nmap --script "ldap*" -p 389 $1 -T4 > ldap-scan.txt
