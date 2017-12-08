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
    
    echo -e '\E[32m'"Distribution :\033[0m" $DISTRIBUTION
    echo -e '\E[32m'"Operating System Type : \033[0m"$(uname -o)
    echo -e '\E[32m'"Achitecture :\033[0m" $(uname -m)
    echo -e '\E[32m'"Kernel :\033[0m" $(uname -s)
    echo -e '\E[32m'"Kernel release :\033[0m" $(uname -r)
    echo -e '\E[32m'"Kernel version :\033[0m" $(uname -v)
    echo ""
    echo -e '\E[32m'"OS Name : \033[0m"$(uname -n)
}



check_ip()
{	
	echo -e '\E[32m'"Interface Machine : ${NC}"
	ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {gsub("/", " "); print $2" "$4}'
}

check_proc()
{
        PROCVERSION=$(cat /proc/cpuinfo | grep "model name" |  awk -F ":" '{print $2}')
        echo -e '\E[32m'"Version processeur : ${NC}" $PROCVERSION
}

check_ram()
{
        echo -e '\E[32m'"Utilisation Mémoire : ${NC}"
	free -h | awk '{print (NR==1?"Type":""), $1, $2, $3, (NR==1?"":$4)}' | column -t | grep ":"
}

check_fs()
{ 
	echo -e '\E[32m'"Pourcentage d'espace utilisé des FileSystems : ${NC}"
	df -h | awk ' {print $6,":  " $5,"sur " $2 " disponible"} '  | grep -E "/dev|/boot|/etc|/home"
}
check_fdisk()
{
	echo -e '\E[32m'"Ensemble des disks : ${NC}"
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
check_fdisk
echo ""
exit 0

