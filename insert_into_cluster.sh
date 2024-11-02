source ips.sh

MONGOS_IP=${IPS[4]}

ssh -i $KEY $USER@$MONGOS_IP << 'EOF'
wget -O /home/ubuntu/data.json https://raw.githubusercontent.com/erik-sytnyk/movies-list/refs/heads/master/db.json

sudo apt install jq

jq '.movies' data.json > movies.json

mongoimport --port 27017 --db testdb --collection movies --file /home/ubuntu/movies.json --jsonArray

mongosh --port $MONGO_PORT1 --eval 'db.getSiblingDB("testdb").movies.find().pretty()'
mongosh --port $MONGO_PORT1 --eval 'db.getSiblingDB("testdb").movies.getShardDistribution()'

EOF

#mongosh --port 27017 --eval 'for (var i = 0; i < 100000; i++) { db.getSiblingDB("testdb").movies.insertOne({"id": "key" + i}) }'
