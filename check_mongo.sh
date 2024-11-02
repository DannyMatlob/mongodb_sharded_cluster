#!/bin/bash

source ips.sh

# MongoDB installation commands to be run on each container
INSTALL_CMDS=$(cat <<EOF
sudo systemctl status mongod
EOF
)

# Connect to each container and install MongoDB
for IP in "${IPS[@]}"; do
  echo "Checking MongoDB on $IP -----------------------------------"
  ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$IP" "bash -c '$INSTALL_CMDS'"
  echo "-----------------------------------------------------------"
done
