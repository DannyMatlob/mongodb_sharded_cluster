# Define the SSH key and user
KEY="dannyKey.pem"
USER="ubuntu"

# Define the IP addresses of the 5 AWS containers
# Shards 1 - 3, Config, Mongos
IPS=(
  "54.242.130.219" # Shard 1
  "54.92.150.80" # Shard 2
  "35.171.89.179" # Shard 3
  "34.235.133.243" # Config
  "54.82.139.128" # Mongos
)

# Define config base directory and mongo ports
BASE_DIR="/db/data"
MONGO_PORT1=27017
MONGO_PORT2=27018
MONGO_PORT3=27019