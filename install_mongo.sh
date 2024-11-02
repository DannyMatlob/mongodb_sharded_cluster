#!/bin/bash

source ips.sh

CONFIG_FILE="/etc/mongod.conf"  # Path to your MongoDB config file
NEW_BIND_IP="0.0.0.0"  # Change this to your desired bind IP

# MongoDB installation commands to be run on each container
INSTALL_CMDS=$(cat <<EOF
sudo apt-get install -y gnupg curl &&
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor &&
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list &&
sudo apt-get update &&
sudo apt-get install -y mongodb-org &&
sudo sed -i.bak "s/^bindIp: .*/bindIp: $NEW_BIND_IP/" "$CONFIG_FILE"
EOF
)

# Connect to each container and install MongoDB
for IP in "${IPS[@]}"; do
  echo "Installing MongoDB on $IP"
  ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$IP" "bash -c '$INSTALL_CMDS'"
  echo "MongoDB installation completed on $IP"
done
