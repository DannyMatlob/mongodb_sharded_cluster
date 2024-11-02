#!/bin/bash

source ips.sh

# MongoDB installation commands to be run on each container
INSTALL_CMDS=$(cat <<EOF
sudo pkill mongod
sudo pkill mongos
sudo rm -rf /db
ls /db
EOF
)

# Connect to each container and stop MongoDB
for IP in "${IPS[@]}"; do
  echo -e "\nClearing all instances of Mongod on $IP"
  ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$IP" "bash -c '$INSTALL_CMDS'"
  echo "Successfully cleared MongoDB on $IP"
  echo "-----------------------------------------------------------"
done
