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

echo ""
check_base

echo ""
exit 0

