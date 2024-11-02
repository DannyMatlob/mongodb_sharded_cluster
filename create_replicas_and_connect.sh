#!/bin/bash

# Source the file containing IP addresses and other variables
source ips.sh

# Connect and run commands on each server


# Shard 1
S1_IP="${IPS[0]}"
echo -e "\n\nSetting up Shard1 at $S1_IP..."
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$S1_IP" << EOF
echo "Creating directories for shard1"
sudo mkdir -p "$BASE_DIR/0"
sudo mkdir -p "$BASE_DIR/1"
sudo mkdir -p "$BASE_DIR/2"
sudo chmod -R 777 /db

echo "Starting mongod as shard server on port $MONGO_PORT1..."
mongod --port $MONGO_PORT1 --dbpath "$BASE_DIR/0" --shardsvr --replSet shard1 --bind_ip_all --fork --logpath "$BASE_DIR/log1.log" &

echo "Starting mongod as shard server on port $MONGO_PORT2..."
mongod --port $MONGO_PORT2 --dbpath "$BASE_DIR/1" --shardsvr --replSet shard1 --bind_ip_all --fork --logpath "$BASE_DIR/log2.log" &

echo "Starting mongod as shard server on port $MONGO_PORT3..."
mongod --port $MONGO_PORT3 --dbpath "$BASE_DIR/2" --shardsvr --replSet shard1 --bind_ip_all --fork --logpath "$BASE_DIR/log3.log" &

sleep 5

echo "Initializing the replica set..."
mongosh --port $MONGO_PORT1 --eval 'rs.initiate()'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S1_IP:$MONGO_PORT2")'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S1_IP:$MONGO_PORT3")'

mongosh --port $MONGO_PORT1 --eval "var cfg = rs.conf(); cfg.members[0].host = '$S1_IP:$MONGO_PORT1'; rs.reconfig(cfg);"

mongosh --port $MONGO_PORT1 --eval 'rs.status()'

echo "Shard1 replica set of 3 initialized successfully."
EOF



# Shard 2
S2_IP="${IPS[1]}"
echo -e "\n\nSetting up Shard2 at $S2_IP..."
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$S2_IP" << EOF
echo "Creating directories for shard2"
sudo mkdir -p "$BASE_DIR/0"
sudo mkdir -p "$BASE_DIR/1"
sudo mkdir -p "$BASE_DIR/2"
sudo chmod -R 777 /db

echo "Starting mongod as shard server on port $MONGO_PORT1..."
mongod --port $MONGO_PORT1 --dbpath "$BASE_DIR/0" --shardsvr --replSet shard2 --bind_ip_all --fork --logpath "$BASE_DIR/log1.log" &

echo "Starting mongod as shard server on port $MONGO_PORT2..."
mongod --port $MONGO_PORT2 --dbpath "$BASE_DIR/1" --shardsvr --replSet shard2 --bind_ip_all --fork --logpath "$BASE_DIR/log2.log" &

echo "Starting mongod as shard server on port $MONGO_PORT3..."
mongod --port $MONGO_PORT3 --dbpath "$BASE_DIR/2" --shardsvr --replSet shard2 --bind_ip_all --fork --logpath "$BASE_DIR/log3.log" &

sleep 5

echo "Initializing the replica set..."
mongosh --port $MONGO_PORT1 --eval 'rs.initiate()'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S2_IP:$MONGO_PORT2")'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S2_IP:$MONGO_PORT3")'

mongosh --port $MONGO_PORT1 --eval "var cfg = rs.conf(); cfg.members[0].host = '$S2_IP:$MONGO_PORT1'; rs.reconfig(cfg);"


mongosh --port $MONGO_PORT1 --eval 'rs.status()'

echo "Shard2 replica set of 3 initialized successfully."
EOF



# Shard 3
S3_IP="${IPS[2]}"
echo -e "\n\nSetting up Shard3 at $S3_IP..."
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$S3_IP" << EOF
echo "Creating directories for shard3"
sudo mkdir -p "$BASE_DIR/0"
sudo mkdir -p "$BASE_DIR/1"
sudo mkdir -p "$BASE_DIR/2"
sudo chmod -R 777 /db

echo "Starting mongod as shard server on port $MONGO_PORT1..."
mongod --port $MONGO_PORT1 --dbpath "$BASE_DIR/0" --shardsvr --replSet shard3 --bind_ip_all --fork --logpath "$BASE_DIR/log1.log" &

echo "Starting mongod as shard server on port $MONGO_PORT2..."
mongod --port $MONGO_PORT2 --dbpath "$BASE_DIR/1" --shardsvr --replSet shard3 --bind_ip_all --fork --logpath "$BASE_DIR/log2.log" &

echo "Starting mongod as shard server on port $MONGO_PORT3..."
mongod --port $MONGO_PORT3 --dbpath "$BASE_DIR/2" --shardsvr --replSet shard3 --bind_ip_all --fork --logpath "$BASE_DIR/log3.log" &

sleep 5

echo "Initializing the replica set..."
mongosh --port $MONGO_PORT1 --eval 'rs.initiate()'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S3_IP:$MONGO_PORT2")'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$S3_IP:$MONGO_PORT3")'

mongosh --port $MONGO_PORT1 --eval "var cfg = rs.conf(); cfg.members[0].host = '$S3_IP:$MONGO_PORT1'; rs.reconfig(cfg);"


mongosh --port $MONGO_PORT1 --eval 'rs.status()'

echo "Shard3 replica set of 3 initialized successfully."
EOF



# Config
CONFIG_IP="${IPS[3]}"
echo -e "\n\nSetting up config at $CONFIG_IP..."
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$CONFIG_IP" << EOF
echo "Creating directories for config servers"
sudo mkdir -p "$BASE_DIR/0"
sudo mkdir -p "$BASE_DIR/1"
sudo mkdir -p "$BASE_DIR/2"
sudo chmod -R 777 /db

echo "Starting mongod as config server on port $MONGO_PORT1..."
mongod --port $MONGO_PORT1 --dbpath "$BASE_DIR/0" --configsvr --replSet config --bind_ip_all --fork --logpath "$BASE_DIR/log1.log" &

echo "Starting mongod as config server on port $MONGO_PORT2..."
mongod --port $MONGO_PORT2 --dbpath "$BASE_DIR/1" --configsvr --replSet config --bind_ip_all --fork --logpath "$BASE_DIR/log2.log" &

echo "Starting mongod as config server on port $MONGO_PORT3..."
mongod --port $MONGO_PORT3 --dbpath "$BASE_DIR/2" --configsvr --replSet config --bind_ip_all --fork --logpath "$BASE_DIR/log3.log" &

sleep 5

echo "Initializing the replica set..."
mongosh --port $MONGO_PORT1 --eval 'rs.initiate()'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$CONFIG_IP:$MONGO_PORT2")'
mongosh --port $MONGO_PORT1 --eval 'rs.add("$CONFIG_IP:$MONGO_PORT3")'

mongosh --port $MONGO_PORT1 --eval "var cfg = rs.conf(); cfg.members[0].host = '$CONFIG_IP:$MONGO_PORT1'; rs.reconfig(cfg);"

mongosh --port $MONGO_PORT1 --eval 'rs.status()'

echo "Replica set of three config servers initialized successfully."
EOF



# Mongos
MONGOS_IP="${IPS[4]}"
echo -e "\n\nSetting up MONGOS at $MONGOS_IP..."
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$MONGOS_IP" << EOF
sudo mkdir -p "$BASE_DIR"
sudo chmod -R 777 /db

mongos --configdb config/$CONFIG_IP:$MONGO_PORT1 --port $MONGO_PORT1 --bind_ip_all --fork --logpath $BASE_DIR/mongos.log

echo "Status before adding any shards"
mongosh --port $MONGO_PORT1 --eval 'sh.status()'

echo "Adding shards"
mongosh --port $MONGO_PORT1 --eval 'sh.addShard("shard1/$S1_IP:$MONGO_PORT1")'
mongosh --port $MONGO_PORT1 --eval 'sh.addShard("shard2/$S2_IP:$MONGO_PORT1")'
mongosh --port $MONGO_PORT1 --eval 'sh.addShard("shard3/$S3_IP:$MONGO_PORT1")'

echo "Adding db and shard collection"
mongosh --port $MONGO_PORT1 --eval 'sh.enableSharding("testdb")'
mongosh --port $MONGO_PORT1 --eval 'sh.shardCollection("testdb.movies", {id: "hashed"})' 

echo "Fixing chunksize to 1mb"
mongosh --port $MONGO_PORT1 --eval 'db.getSiblingDB("testdb").settings.updateOne({ _id: "chunksize" },{ \$set: { _id: "chunksize", value: 1} },{ upsert: true })'

echo "Shard Status after adding shards"
mongosh --port $MONGO_PORT1 --eval 'sh.status()'
EOF
