# Define the SSH key and user
KEY="dannyKey.pem"
USER="ubuntu"

# Define the IP addresses of the 5 AWS containers
# Shards 1 - 3, Config, Mongos
IPS=(
  "54.210.49.223" # Shard 1
  "34.207.195.71" # Shard 2
  "54.225.3.188" # Shard 3
  "54.85.100.174" # Config
  "54.166.163.43" # Mongos
)

# Define config base directory and mongo ports
BASE_DIR="/db/data"
MONGO_PORT1=27017
MONGO_PORT2=27018
MONGO_PORT3=27019