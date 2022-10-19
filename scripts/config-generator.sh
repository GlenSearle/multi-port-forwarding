#!/bin/bash
# This script take a list of server on the local network from a file and make configuration file for each entry.
# The format of the data is NAME comma IP_ADDRESS, eg:
#    paymentgateway,10.0.0.69
#    database,10.0.0.137

# 


# This writes to the configuration file.
input="servers.csv"
while IFS= read -r line
do
	address=$(echo $line | cut -f1 -d,)
	name=$(echo $line | cut -f2 -d,)
	ports=""
	scanOutput=""
	ls "${address}.log"
	while IFS= read -r nmap
	do
		if [[ $(echo ${nmap} | grep tcp) ]]
		then
			ports="${ports} $(echo ${nmap}| cut -d/ -f1)"
			scanOutput="${scanOutput}\n#${nmap}"
		fi
	done < ${address}.log
	PORT_LIST=$(echo ${ports}| sed 's/^ //')
	echo ". ${ports}"
	cat <<EOF > $([ "${whoami}" = "root" ] && echo "/etc/default/")multi-port-forwarding@${name}.service
DESTINATION_ADDRESS=${address}
LISTENING_ADDRESS=${address}
LISTENING_PORTS=(${PORT_LIST})
DESTINATION_PORTS=(${PORT_LIST})

# output of nmap
$(echo -e ${scanOutput})
EOF
done < $input

[ "${whoami}" != "root" ] && echo "As you are not running as root, you'll need to copy the service files to /etc/default"

