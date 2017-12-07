#!/bin/bash

## COLOR
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"
NC='\033[0m'

check_base()
{
    # Check OS Type
    os=$(uname -o)
    echo -e '\E[32m'"Operating System Type : \033[0m"$os

    # Check OS Release Version and Name
    os_name=$(uname -n)
    echo -e '\E[32m'"OS Name : \033[0m"$os_name

    os_version=$(uname -v)
    echo -e '\E[32m'"OS Version : \033[0m" $os_version

    # Check Architecture
    architecture=$(uname -m)
    echo -e '\E[32m'"Architecture : \033[0m"$architecture

    # Check Kernel Release
    kernelrelease=$(uname -r)
    echo -e '\E[32m'"Kernel Release : \033[0m"$kernelrelease

    # Check hostname
    echo -e '\E[32m'"Hostname : \033[0m"$HOSTNAME
}

check_ip()
{
	echo -e '\E[32m'"Interface Machine : ${NC}"
	ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {gsub("/", " "); print $2" "$4}'
}

check_ram()
{
        echo -e '\E[32m'"Utilisation Mémoire : ${NC}"
	free -h | awk '{print (NR==1?"Type":""), $1, $2, $3, (NR==1?"":$4)}' | column -t | grep ":"
}

echo ""
check_base
echo ""
check_ip
echo ""
check_ram
echo ""

exit 0

