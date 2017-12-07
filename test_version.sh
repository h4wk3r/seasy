if [[ -f /etc/debian_version || -f /etc/redhat_release ]]  
then echo "present" 
else echo "absent"
fi

