if [ -f /etc/debian_version ]
   then
       echo "Fichier de distribution debian trouvé" 
       DISTRIBUTION="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ] 
   then
       echo "Fichier de distribution redhat trouvé"
       DISTRIBUTION=$(cat /etc/redhat-release)
   else
       echo "Fichier de distribution absent"
fi

echo "architecture : $(uname -m)"
echo "distribution : $DISTRIBUTION"
echo "kernel : $(uname -s)"
echo "kernel release : $(uname -r)"
echo "kernel version : $(uname -v)"

