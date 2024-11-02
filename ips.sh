# Define the SSH key and user
KEY="dannyKey.pem"
USER="ubuntu"

# Define the IP addresses of the 5 AWS containers
# Shards 1 - 3, Config, Mongos
IPS=(
  "34.201.217.210" # Shard 1
  "3.87.41.235" # Shard 2
  "98.81.209.128" # Shard 3
  "3.93.71.207" # Config
  "54.172.200.159" # Mongos
)

# Define config base directory and mongo ports
BASE_DIR="/db/data"
MONGO_PORT1=27017
MONGO_PORT2=27018
MONGO_PORT3=27019