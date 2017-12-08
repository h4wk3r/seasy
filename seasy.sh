#!/bin/bash

## COLOR
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"
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
       DISTRIBUTION="Fichier de distribution absent" 
    fi
    echo -e "${GREEN}OS Name : \033[0m"$(uname -n)    
    echo -e "${GREEN}Achitecture :\033[0m" $(uname -m)
    echo -e "${GREEN}Kernel :\033[0m" $(uname -s)
    echo -e "${GREEN}Kernel release :\033[0m" $(uname -r)
    echo -e "${GREEN}Date :\033[0m" $(date | awk '{print $1, $2, $3, $4, $5}')
    echo -e "${GREEN}Uptime :\033[0m" $(uptime | awk '{print $1}')
    echo ""
    echo -e "${GREEN}Utilisateur(s) connecté(s) :\033[0m" 
    echo $(who | awk '{print $1}' | sort | uniq)

}



check_ip()
{	
	echo -e "${GREEN}Interface Machine : ${NC}"
	ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {gsub("/", " "); print $2" "$4}'
}

check_proc()
{
        PROCVERSION=$(cat /proc/cpuinfo | grep "model name" |  awk -F ":" '{print $2}')
	PROCIDLE=$(top -b -n1 | grep Cpu | awk '{print $8}')
	PROCUSAGE=100-$PROCIDLE
        echo -e "${GREEN}Version processeur : ${NC}" $PROCVERSION
        echo -e "${GREEN}Utilisation processeur : ${NC}" $PROCUSAGE
}

check_ram()
{
        echo -e "${GREEN}Utilisation Mémoire : ${NC}"
	free -h | awk '{print (NR==1?"Type":""), $1, $2, $3, (NR==1?"":$4)}' | column -t | grep ":"
}

check_fs()
{ 
	echo -e "${GREEN}FileSystems / Disk : ${NC}"
	check_fdisk
	df -h | awk ' {print $6,":  " $5,"sur " $2 " disponible"} '  | grep -E "/dev|/boot|/etc|/home"
}
check_fdisk()
{
	#echo -e "${GREEN}Ensemble des disks : ${NC}"
	fdisk -l | grep -E "Disque /dev/s|Disk /dev/s" | cut -d "," -f 1
}

echo""
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

