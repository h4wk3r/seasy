#!/bin/bash

## COLOR
GREEN="\\033[1;32m"
CY="\\033[1;36m"

NC='\033[0m'

check_distribution()
{
       if [ -f /etc/debian_version ]
       then
                DISTRIBUTION="Debian $(cat /etc/debian_version)"
        elif [ -f /etc/redhat-release ] 
        then
		DISTRIBUTION=$(cat /etc/redhat-release)
	else
		DISTRIBUTION="Distribution file absent" 
	fi
	echo -e "${CY}OS Name : \033[0m"$(uname -n)    
	echo -e "${CY}Achitecture :\033[0m" $(uname -m)
	echo -e "${CY}Kernel :\033[0m" $(uname -s)
	echo -e "${CY}Kernel release :\033[0m" $(uname -r)
	echo -e "${CY}Date :\033[0m" $(date | awk '{print $1, $2, $3, $4, $5}')
	echo -e "${CY}Uptime :\033[0m" $(uptime -p)
	echo ""
	echo -e "${GREEN}Connected user(s):\033[0m" 
	echo $(who | awk '{print $1}' | sort | uniq)

}

check_ip()
{
	echo -e "${GREEN}Network interface(s) : ${NC}"
	ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {gsub("/", " "); print $2" "$4}'
}

check_proc()
{
	PROCIDLE=$(top -b -n1 | grep Cpu | awk '{print $8}')
	CPUMHZ=$(cat /proc/cpuinfo | grep MHz | awk -F ":" '{print $2}')
	let PROCUSAGE=100-$PROCIDLE
        echo -e "${GREEN}CPU Infos : ${NC}"
	echo "CPU Power:$CPUMHZ MHz"
	echo "CPU usage: $PROCUSAGE%"
}

check_ram()
{
        echo -e "${GREEN}Memory usage : ${NC}"
	free -h | awk '{print (NR==1?"Type":""), $1, $2, $3, (NR==1?"":$4)}' | column -t | grep ":" | grep -v [+]
}

check_fs()
{ 
	echo -e "${GREEN}FileSystems / Disk : ${NC}"
	check_fdisk
	df -h | awk ' {print $6,":  " $5,"sur " $2 " disponible"} '  | grep -E "/dev|/boot|/etc|/home"
}

check_fdisk()
{
	fdisk -l | grep -E "Disk /dev/s|Disk /dev/s" | cut -d "," -f 1
}

echo ""
check_distribution
echo ""
check_ip
echo ""
check_proc
echo ""
check_ram
echo ""
check_fs
echo ""

exit 0

